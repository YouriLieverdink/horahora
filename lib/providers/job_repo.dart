import 'package:automatons/models/user.dart';
import 'package:automatons/repositories/job.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Middleware jobRepoProvider() {
  return provider((context) {
    final db = context.read<Db>();
    final user = context.read<User>();

    return JobRepo(db: db, user: user);
  });
}
