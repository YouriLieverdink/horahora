import 'package:automatons/models/user.dart';
import 'package:automatons/repositories/session.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Middleware sessionRepoProvider() {
  return provider((context) {
    final db = context.read<Db>();
    final user = context.read<User>();

    return SessionRepo(db: db, user: user);
  });
}
