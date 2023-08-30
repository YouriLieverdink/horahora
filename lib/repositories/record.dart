import 'package:automatons/models/record.dart';
import 'package:automatons/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

const collection = 'hours-records';

class RecordRepo {
  final Db db;
  final User user;

  const RecordRepo({
    required this.db,
    required this.user,
  });

  Future<List<Record>> findAll(
    String from,
    String to,
  ) async {
    final data = await db //
        .collection(collection)
        .find(
          where
              .gte('start', from)
              .and(where.lt('start', to))
              .and(where.eq('userId', user.id)),
        )
        .toList();

    return data //
        .map(Record.fromJson)
        .toList();
  }

  Future<void> insertOne(
    DateTime start,
    DateTime end,
  ) async {
    final data = {
      '_id': ObjectId(),
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'userId': user.id,
    };

    await db //
        .collection(collection)
        .insertOne(data);
  }
}
