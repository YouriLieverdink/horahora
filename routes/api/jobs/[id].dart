import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:horahora/repositories/job.dart';

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
  final name = pick(json, 'name').asStringOrThrow();

  final job = await jobRepo.updateById(id, name);

  return Response.json(
    body: job,
  );
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
