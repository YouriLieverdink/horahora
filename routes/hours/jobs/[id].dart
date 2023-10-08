
import 'dart:async';
import 'dart:io';

import 'package:automatons/repositories/job.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String id,
) async {
  switch (context.request.method) {
    case HttpMethod.put:
      return _put(context, id);
    case HttpMethod.delete:
      return _delete(context, id);

    default:
      return Response(
        statusCode: HttpStatus.methodNotAllowed,
      );
  }
}

FutureOr<Response> _put(
  RequestContext context,
  String id,
) async {
  final jobRepo = context.read<JobRepo>();
  final json = await context.request.json();

  try {
    final name = pick(json, 'name').asStringOrThrow();
    final job = await jobRepo.updateById(id, name);

    return Response.json(
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

FutureOr<Response> _delete(
  RequestContext context,
  String id,
) async {
  final jobRepo = context.read<JobRepo>();

  await jobRepo.deleteById(id);

  return Response(
    statusCode: HttpStatus.noContent,
  );
}
