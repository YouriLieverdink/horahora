import 'dart:async';
import 'dart:io';

import 'package:automatons/models/user.dart';
import 'package:automatons/repositories/session.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(
  RequestContext context,
) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);

    default:
      return Response(
        statusCode: HttpStatus.methodNotAllowed,
      );
  }
}

FutureOr<Response> _get(
  RequestContext context,
) async {
  final sessionRepo = context.read<SessionRepo>();

  final status = await sessionRepo.findAll(limit: 1);

  return Response.json(
    body: status.isEmpty //
        ? 'Off the clock'
        : 'On the clock',
  );
}
