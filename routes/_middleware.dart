import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

const localDbUrl = 'mongodb://localhost:27017/automatons';

Handler middleware(Handler handler) {
  final db = Db(Platform.environment['dbUrl'] ?? localDbUrl);

  return (context) async {
    final context_ = context.provide<Db>(() => db);

    await db.open();
    final response = handler(context_);
    await db.close();

    return response;
  };
}
