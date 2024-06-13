import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/repositories/job.dart';
import 'package:horahora/repositories/record.dart';
import 'package:horahora/repositories/session.dart';
import 'package:horahora/repositories/user.dart';

FutureOr<Response> onRequest(
  RequestContext context,
) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.delete:
      return _delete(context);

    default:
      return Response(
        statusCode: HttpStatus.methodNotAllowed,
      );
  }
}

FutureOr<Response> _get(
  RequestContext context,
) async {
  final user = context.read<User>();

  return Response.json(
    body: user,
  );
}

FutureOr<Response> _delete(
  RequestContext context,
) async {
  final userRepo = context.read<UserRepo>();
  final user = context.read<User>();

  final jobRepo = context.read<JobRepo>();
  await jobRepo.deleteAllByUser(user.id);

  final recordRepo = context.read<RecordRepo>();
  await recordRepo.deleteAllByUser(user.id);

  final sessionRepo = context.read<SessionRepo>();
  await sessionRepo.deleteAllByUser(user.id);

  await userRepo.deleteById(user.id);

  return Response(
    statusCode: HttpStatus.noContent,
  );
}
