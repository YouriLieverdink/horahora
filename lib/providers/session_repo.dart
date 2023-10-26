import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/repositories/session.dart';
import 'package:mongo_dart/mongo_dart.dart';

Middleware sessionRepoProvider() {
  return provider((context) {
    final db = context.read<Db>();
    final user = context.read<User>();

    return SessionRepo(db: db, user: user);
  });
}
