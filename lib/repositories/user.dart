import 'package:horahora/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

const collection = 'users';

class UserRepo {
  final Db db;

  const UserRepo({
    required this.db,
  });

  Future<User?> getUserByToken(
    String token,
  ) async {
    final data = await db //
        .collection(collection)
        .findOne(where.eq('token', token));

    if (data != null) {
      return User.fromJson(data);
    }

    return null;
  }
}
