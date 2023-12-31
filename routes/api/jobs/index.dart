import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/repositories/job.dart';

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
  final jobs = await jobRepo.findAll();

  return Response.json(
    body: jobs,
  );
}

FutureOr<Response> _post(
  RequestContext context,
) async {
  final jobRepo = context.read<JobRepo>();

  final json = await context.request.json();
  final form = JobForm.fromJson(json);

  final job = await jobRepo.insertOne(form);

  return Response.json(
    statusCode: HttpStatus.created,
    body: job,
  );
}
