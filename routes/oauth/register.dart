import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/repositories/user.dart';
import 'package:horahora/utilities/jwt.dart';

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
  final userRepo = context.read<UserRepo>();

  final json = await context.request.json();
  final form = JwtForm.fromJson(json);

  final existing = await userRepo.findUserByEmail(form.email);
  if (existing != null) {
    return Response.json(
      statusCode: HttpStatus.conflict,
      body: [
        Error(
          code: 'conflict',
          message: 'User: ${form.email} already exists.',
        ),
      ],
    );
  }

  final user = await userRepo.insertOne(form);
  final token = makeJwt(user);

  return Response.json(
    statusCode: HttpStatus.created,
    body: Jwt(token: token),
  );
}
