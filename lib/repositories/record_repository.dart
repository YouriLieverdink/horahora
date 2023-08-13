import 'package:automatons/models/record.dart';
import 'package:automatons/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

const collection = 'hours-records';

class RecordRepository {
  final Db db;
  final User user;

  const RecordRepository({
    required this.db,
    required this.user,
  });

  Future<List<Record>> findAll(
    String from,
    String to,
  ) async {
    final userId = user.id.toHexString();

    final documents = await db //
        .collection(collection)
        .find(
          where
              .gte('start', from)
              .and(where.lt('start', to))
              .and(where.eq('userId', userId)),
        )
        .toList();

    return documents //
        .map(Record.fromDocument)
        .toList();
  }
}
