import 'dart:async';
import 'dart:io';

import 'package:automatons/repositories/record.dart';
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

  if (currentSession == null) {
    // The user must start a session before they can stop it.
    return Response.json(
      statusCode: HttpStatus.conflict,
      body: {
        'status': 'No session found',
        'data': null,
      },
    );
  }

  final recordRepo = context.read<RecordRepo>();
  final newRecord = await recordRepo.insertOne(
    currentSession.start,
    DateTime.now(),
  );

  await sessionRepo.deleteOne(currentSession.id);

  return Response.json(
    body: {
      'status': 'Session stopped',
      'data': newRecord,
    },
  );
}
