import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:horahora/repositories/job.dart';
import 'package:horahora/repositories/session.dart';

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
  final sessionRepo = context.read<SessionRepo>();
  final jobRepo = context.read<JobRepo>();

  final json = await context.request.json();
  final jobId = pick(json, 'jobId').asStringOrThrow();

  final job = await jobRepo.findById(jobId);
  if (job == null) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: 'Job: $jobId not found.',
    );
  }

  final existing = await sessionRepo.findByJob(jobId);
  if (existing != null) {
    return Response.json(
      statusCode: HttpStatus.conflict,
      body: 'Session for job: $jobId already active.',
    );
  }

  final session = await sessionRepo.insertOne(jobId);

  return Response.json(
    statusCode: HttpStatus.created,
    body: session,
  );
}
