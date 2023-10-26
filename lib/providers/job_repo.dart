import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/repositories/job.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../generated/nl_iruoy_horahora_v0_json.dart' as i1;

Middleware jobRepoProvider() {
  return provider((context) {
    final db = context.read<Db>();
    final user = context.read<i1.User>();

    return JobRepo(db: db, user: user);
  });
}
