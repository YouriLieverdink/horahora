import 'dart:io';

import 'package:automatons/domain/domain.dart';
import 'package:automatons/repositories/user.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';

Handler middleware(
  Handler handler,
) {
  return (context) async {
    try {
      await db.open();

      final response = await handler //
          .use(requestLogger())
          .use(provider((_) => db))
          .use(provider((_) => UserRepo(db: db)))
          .call(context);

      await db.close();

      return response;
    } on PickException catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: e.toString(),
      );
    } catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: e.toString(),
      );
    }
  };
}
