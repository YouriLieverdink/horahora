import 'package:horahora/utilities/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../generated/nl_iruoy_horahora_v0_json.dart' as i1;

const collection = 'hours-sessions';

class SessionRepo {
  final Db db;
  final i1.User user;

  const SessionRepo({
    required this.db,
    required this.user,
  });

  Future<List<i1.Session>> findAll() async {
    final data = await db //
        .collection(collection)
        .find()
        .toList();

    return data //
        .map(objectIdToString)
        .map(i1.Session.fromJson)
        .toList();
  }

  Future<i1.Session?> findByJob(
    String jobId,
  ) async {
    final data = await db //
        .collection(collection)
        .findOne(
          where.eq('jobId', jobId),
        );

    if (data != null) {
      return i1.Session.fromJson(objectIdToString(data));
    }

    return null;
  }

  Future<i1.Session> insertOne(
    i1.SessionForm form,
  ) async {
    final data = {
      '_id': ObjectId(),
      'start': DateTime.now().toIso8601String(),
      'userId': user.id,
      'jobId': form.jobId,
    };

    await db //
        .collection(collection)
        .insertOne(data);

    return i1.Session.fromJson(objectIdToString(data));
  }

  Future<void> deleteOne(
    String id,
  ) async {
    await db //
        .collection(collection)
        .deleteOne(
          where.id(
            ObjectId.fromHexString(id),
          ),
        );
  }
}
