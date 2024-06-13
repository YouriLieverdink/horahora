import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:horahora/extensions/record.dart';
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
  String fromDate,
  String toDate,
) async {
  final recordRepo = context.read<RecordRepo>();

  final query = context.request.uri.queryParameters;
  final jobId = pick(query, 'jobId').asStringOrThrow();

  final records = await recordRepo.findAll(fromDate, toDate, jobId);
  final csv = records.toCsv();

  return Response.bytes(
    body: utf8.encode(csv),
  );
}
