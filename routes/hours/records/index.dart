import 'dart:async';
import 'dart:io';

import 'package:automatons/repositories/record.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';

FutureOr<Response> onRequest(
  RequestContext context,
) async {
  switch (context.request.method) {
    case HttpMethod.post:
      return _post(context);

    default:
      return Response(
        statusCode: HttpStatus.methodNotAllowed,
      );
  }
}

FutureOr<Response> _post(
  RequestContext context,
) async {
  final records = context.read<RecordRepo>();
  final json = await context.request.json();

  // Retrieve the data.
  try {
    final start = pick(json, 'start').asDateTimeOrThrow();
    final end = pick(json, 'end').asDateTimeOrThrow();

    await records.insertOne(start, end);

    return Response(
      statusCode: HttpStatus.created,
    );
  } //
  on PickException catch (e) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: e.message,
    );
  }
}
