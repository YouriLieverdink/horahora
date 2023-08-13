import 'package:automatons/models/user.dart';
import 'package:automatons/repositories/record_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Handler middleware(
  Handler handler,
) {
  return (context) async {
    final db = context.read<Db>();
    final user = context.read<User>();

    final records = RecordRepository(
      db: db,
      user: user,
    );

    return handler(
      context.provide(() => records),
    );
  };
}
