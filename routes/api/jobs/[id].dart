import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart' as i1;
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
  final form = i1.JobForm.fromJson(json);

  final job = await jobRepo.updateById(id, form);

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
