import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:horahora/domain/domain.dart';
import 'package:horahora/repositories/record.dart';
import 'package:horahora/utilities/record.dart';
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
  final jobId = pick(json, 'jodId').asStringOrNull();
  final from = pick(json, 'from').asStringOrThrow();
  final to = pick(json, 'to').asStringOrThrow();
  final subject = pick(json, 'subject').asStringOrThrow();
  final body = pick(json, 'body').asStringOrThrow();

  final records = await recordRepo.findAll(fromDate, toDate, jobId);
  final csv = recordsToCsv(records);

  // Replace variables within export body.
  var html = body;
  html = html.replaceAll('[durationInHours]', totalDurationInHours(records));

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
