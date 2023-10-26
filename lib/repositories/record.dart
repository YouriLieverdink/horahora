import 'package:horahora/utilities/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../generated/nl_iruoy_horahora_v0_json.dart' as i1;

const collection = 'hours-records';

class RecordRepo {
  final Db db;
  final i1.User user;

  const RecordRepo({
    required this.db,
    required this.user,
  });

  Future<List<i1.Record>> findAll(
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
        .map(i1.Record.fromJson)
        .toList();
  }

  Future<i1.Record> insertOne(
    i1.RecordForm form,
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

    return i1.Record.fromJson(objectIdToString(data));
  }
}
