import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:horahora/extensions/request.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/utilities/jwt.dart';

Middleware jwt({
  required Future<User?> Function(String?) getUserById,
}) {
  return (handler) {
    return (context) async {
      final bearer = context.request.bearer();

      if (bearer != null) {
        try {
          final jwt = verifyJwt(bearer);
          final user = await getUserById(jwt.subject);

          if (user != null) {
            return handler(
              context.provide(() => user),
            );
          }
        } //
        on JWTExpiredException {
          return Response(
            statusCode: HttpStatus.unauthorized,
            body: 'JWT expired.',
          );
        } //
        catch (_) {
          return Response(
            statusCode: HttpStatus.unauthorized,
          );
        }
      }

      return Response(
        statusCode: HttpStatus.unauthorized,
      );
    };
  };
}
