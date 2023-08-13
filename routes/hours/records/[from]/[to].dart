import 'dart:async';
import 'dart:io';

import 'package:automatons/repositories/record_repository.dart';
import 'package:dart_frog/dart_frog.dart';

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
  final records = context.read<RecordRepository>();
  final data = await records.findAll(from, to);

  return Response.json(
    body: data,
  );
}
