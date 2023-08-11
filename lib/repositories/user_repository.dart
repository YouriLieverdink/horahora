import 'package:automatons/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

const collection = 'users';

class UserRepository {
  final Db db;

  const UserRepository({
    required this.db,
  });

  Future<User?> getUserByToken(
    String token,
  ) async {
    final document = await db //
        .collection(collection)
        .findOne(where.eq('token', token));

    if (document != null) {
      return User.fromDocument(document);
    }

    return null;
  }
}
