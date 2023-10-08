import 'package:automatons/models/session.dart';
import 'package:automatons/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

const collection = 'hours-sessions';

class SessionRepo {
  final Db db;
  final User user;

  const SessionRepo({
    required this.db,
    required this.user,
  });

  Future<List<Session>> findAll() async {
    final data = await db //
        .collection(collection)
        .find()
        .toList();

    return data //
        .map(Session.fromJson)
        .toList();
  }

  Future<Session?> findByJob(
    String jobId,
  ) async {
    final data = await db //
        .collection(collection)
        .findOne(
          where.eq('jobId', jobId),
        );

    if (data != null) {
      return Session.fromJson(data);
    }

    return null;
  }

  Future<Session> insertOne(
    String jobId,
  ) async {
    final data = {
      '_id': ObjectId(),
      'start': DateTime.now().toIso8601String(),
      'userId': user.id,
      'jobId': jobId,
    };

    await db //
        .collection(collection)
        .insertOne(data);

    return Session.fromJson(data);
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
