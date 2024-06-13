import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/utilities/mongo.dart';
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
    String? jobId,
  ) async {
    var selector = where
        .gte('start', from)
        .and(where.lt('start', to))
        .and(where.eq('userId', user.id))
        .sortBy('start', descending: true);

    if (jobId != null) {
      selector = selector.and(where.eq('jobId', jobId));
    }

    final data = await db //
        .collection(collection)
        .find(selector)
        .toList();

    return data //
        .map(objectIdToString)
        .map(Record.fromJson)
        .toList();
  }

  Future<Record> insertOne(
    RecordForm form,
  ) async {
    final data = {
      '_id': ObjectId(),
      'start': form.start.toIso8601String(),
      'end': form.end.toIso8601String(),
      'userId': user.id,
      'jobId': form.jobId,
    };

    await db //
        .collection(collection)
        .insertOne(data);

    return Record.fromJson(objectIdToString(data));
  }

  Future<void> deleteAllByUser(
    String userId,
  ) async {
    await db //
        .collection(collection)
        .deleteMany(where.eq('userId', userId));
  }
}
