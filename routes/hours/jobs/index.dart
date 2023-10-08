import 'dart:async';
import 'dart:io';

import 'package:automatons/repositories/job.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';

FutureOr<Response> onRequest(
  RequestContext context,
) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
      return _post(context);

    default:
      return Response(
        statusCode: HttpStatus.methodNotAllowed,
      );
  }
}

FutureOr<Response> _get(
  RequestContext context,
) async {
  final jobRepo = context.read<JobRepo>();
  final data = await jobRepo.findAll();

  return Response.json(
    body: data,
  );
}

FutureOr<Response> _post(
  RequestContext context,
) async {
  final jobRepo = context.read<JobRepo>();
  final json = await context.request.json();

  try {
    final name = pick(json, 'name').asStringOrThrow();
    final job = await jobRepo.insertOne(name);

    return Response.json(
      statusCode: HttpStatus.created,
      body: job,
    );
  } //
  on PickException catch (e) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: e.message,
    );
  }
}
