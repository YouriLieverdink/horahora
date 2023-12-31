import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/repositories/record.dart';
import 'package:mongo_dart/mongo_dart.dart';

Middleware recordRepoProvider() {
  return provider((context) {
    final db = context.read<Db>();
    final user = context.read<User>();

    return RecordRepo(db: db, user: user);
  });
}
