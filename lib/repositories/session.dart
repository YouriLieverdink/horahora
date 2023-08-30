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

  Future<List<Session>> findAll({
    required int limit,
  }) async {
    final data = await db //
        .collection(collection)
        .find(
          where //
              .eq('userId', user.id)
              .limit(limit),
        )
        .toList();

    return data //
        .map(Session.fromJson)
        .toList();
  }
}
