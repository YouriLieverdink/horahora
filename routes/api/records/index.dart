import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart' as i1;
import 'package:horahora/repositories/job.dart';
import 'package:horahora/repositories/record.dart';

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
  final recordRepo = context.read<RecordRepo>();
  final jobRepo = context.read<JobRepo>();

  final json = await context.request.json();
  final form = i1.RecordForm.fromJson(json);

  final job = await jobRepo.findById(form.jobId);
  if (job == null) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: 'Job: ${form.jobId} not found.',
    );
  }

  final record = await recordRepo.insertOne(form);

  return Response.json(
    statusCode: HttpStatus.created,
    body: record,
  );
}
