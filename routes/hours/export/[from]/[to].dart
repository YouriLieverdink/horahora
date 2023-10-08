import 'dart:async';
import 'dart:io';

import 'package:automatons/domain/domain.dart';
import 'package:automatons/repositories/record.dart';
import 'package:csv/csv.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:mailer/mailer.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String from,
  String to,
) async {
  switch (context.request.method) {
    case HttpMethod.post:
      return _post(context, from, to);

    default:
      return Response(
        statusCode: HttpStatus.methodNotAllowed,
      );
  }
}

FutureOr<Response> _post(
  RequestContext context,
  String fromDate,
  String toDate,
) async {
  final recordRepo = context.read<RecordRepo>();

  final json = await context.request.json();
  final from = pick(json, 'from').asStringOrThrow();
  final to = pick(json, 'to').asStringOrThrow();
  final subject = pick(json, 'subject').asStringOrThrow();
  final body = pick(json, 'body').asStringOrThrow();

  final records = await recordRepo.findAll(fromDate, toDate);

  final List<List<dynamic>> csvData = [];
  csvData.add(['start', 'end', 'duration']);
  for (final rec in records) {
    csvData.add([rec.start.toIso8601String(), rec.end.toIso8601String(), rec.duration.inSeconds / 60 / 60]);
  }
  final csv = const ListToCsvConverter().convert(csvData);

  // We allow the user to adjust their body with some variables.
  final durationInSeconds = records //
    .map((record) => record.duration.inSeconds)
    .fold(0, (prev, curr) => prev + curr);
  final durationInHours = durationInSeconds / 60 / 60;

  String html = body;
  html = html.replaceAll('[durationInHours]', durationInHours.toStringAsFixed(2));

  final message = Message()
    ..from = Address(from, 'Youri Lieverdink')
    ..recipients.add(to)
    ..subject = subject
    ..html = html
    ..attachments.add(
      StringAttachment(
        csv,
        contentType: 'text/csv',
        fileName: 'export.csv',
      ),
    );

  await send(message, smtp);

  return Response.json(
    body: 'Export has been successful',
  ); 
}
