import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:horahora/domain/domain.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/repositories/user.dart';

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
    } //
    on PickException catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: [
          Error(
            code: 'badRequest',
            message: e.message,
          ),
        ],
      );
    } //
    catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: [
          const Error(
            code: 'internalServerError',
            message: 'Whoops!',
          ),
        ],
      );
    }
  };
}
