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

  final user = await userRepo.findUserByCredentials(form.email, form.password);
  if (user == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: const [
        Error(
          code: 'unauthorized',
          message: 'Credentials incorrect.',
        ),
      ],
    );
  }

  final token = makeJwt(user);

  return Response.json(
    body: Jwt(token: token),
  );
}
