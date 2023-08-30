import 'dart:async';
import 'dart:io';

import 'package:automatons/repositories/session.dart';
import 'package:dart_frog/dart_frog.dart';

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
  final currentSession = await sessionRepo.findOne();

  if (currentSession != null) {
    // We only allow 1 session at a time.
    return Response.json(
      statusCode: HttpStatus.conflict,
      body: {
        'status': 'Session already in progress',
        'data': null,
      },
    );
  }

  final newSession = await sessionRepo.insertOne();

  return Response.json(
    body: {
      'status': 'Session started',
      'data': newSession,
    },
  );
}
