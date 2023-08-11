import 'dart:io';

import 'package:automatons/const.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Handler middleware(
  Handler handler,
) {
  final dbUrl = Platform.environment['dbUrl'];
  final db = Db(dbUrl ?? localDbUrl);

  return (context) async {
    await db.open();

    final response = await handler //
        .use(requestLogger())
        .use(provider<Db>((_) => db))
        .call(context);

    await db.close();

    return response;
  };
}
