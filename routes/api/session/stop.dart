import 'dart:async';
import 'dart:io';

import 'package:automatons/repositories/job.dart';
import 'package:automatons/repositories/record.dart';
import 'package:automatons/repositories/session.dart';
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

  final current = await sessionRepo.findByJob(jobId);
  if (current == null) {
    return Response.json(
      statusCode: HttpStatus.conflict,
      body: 'Session for job: $jobId not yet active.',
    );
  }

  final recordRepo = context.read<RecordRepo>();
  final record = await recordRepo.insertOne(
    current.start,
    DateTime.now(),
    current.jobId,
  );

  await sessionRepo.deleteOne(current.id);

  return Response.json(
    body: record,
  );
}
