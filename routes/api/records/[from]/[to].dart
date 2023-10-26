import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:horahora/repositories/record.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String from,
  String to,
) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, from, to);

    default:
      return Response(
        statusCode: HttpStatus.methodNotAllowed,
      );
  }
}

FutureOr<Response> _get(
  RequestContext context,
  String from,
  String to,
) async {
  final recordRepo = context.read<RecordRepo>();

  final jobId = pick(
    context.request.url.queryParameters,
    'jobId',
  ).asStringOrNull();

  final records = await recordRepo.findAll(from, to, jobId);

  return Response.json(
    body: records,
  );
}
