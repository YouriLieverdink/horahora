import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/repositories/job.dart';
import 'package:horahora/repositories/record.dart';
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
  final form = SessionForm.fromJson(json);

  final job = await jobRepo.findById(form.jobId);
  if (job == null) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: 'Job: ${form.jobId} not found.',
    );
  }

  final current = await sessionRepo.findByJob(form.jobId);
  if (current == null) {
    return Response.json(
      statusCode: HttpStatus.conflict,
      body: 'Session for job: ${form.jobId} not yet active.',
    );
  }

  final recordRepo = context.read<RecordRepo>();
  final record = await recordRepo.insertOne(
    RecordForm(
      start: current.start,
      end: DateTime.now(),
      jobId: form.jobId,
    ),
  );

  await sessionRepo.deleteOne(current.id);

  return Response.json(
    body: record,
  );
}
