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

  Future<Session?> findOne() async {
    final data = await db //
        .collection(collection)
        .findOne(
          where.eq('userId', user.id),
        );

    if (data != null) {
      return Session.fromJson(data);
    }

    return null;
  }

  Future<Session> insertOne() async {
    final data = {
      '_id': ObjectId(),
      'start': DateTime.now().toIso8601String(),
      'userId': user.id,
    };

    await db //
        .collection(collection)
        .insertOne(data);

    return Session.fromJson(data);
  }

  Future<void> deleteOne(
    String id,
  ) async {
    final id_ = ObjectId.fromHexString(id);

    await db //
        .collection(collection)
        .deleteOne(where.id(id_));
  }
}
