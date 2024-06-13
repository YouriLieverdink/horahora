import 'package:deep_pick/deep_pick.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/utilities/mongo.dart';
import 'package:horahora/utilities/string.dart';
import 'package:mongo_dart/mongo_dart.dart';

const collection = 'users';

class UserRepo {
  final Db db;
  final Uuid uuid;

  const UserRepo({
    required this.db,
    this.uuid = const Uuid(),
  });

  Future<User?> findUserById(
    String? id,
  ) async {
    if (id == null) {
      return null;
    }

    final data = await db //
        .collection(collection)
        .findOne(
          where.id(
            ObjectId.fromHexString(id),
          ),
        );

    if (data != null) {
      return User.fromJson(objectIdToString(data));
    }

    return null;
  }

  Future<User?> findUserByEmail(
    String email,
  ) async {
    final data = await db //
        .collection(collection)
        .findOne(where.eq('email', email));

    if (data != null) {
      return User.fromJson(objectIdToString(data));
    }

    return null;
  }

  Future<User?> findUserByCredentials(
    String email,
    String password,
  ) async {
    final data = await db //
        .collection(collection)
        .findOne(
          where.eq('email', email),
        );

    if (data == null) {
      return null;
    }

    // Verify that the passwords match
    final hash = pick(data, 'password').asStringOrNull();
    if (hash == null || !compareHash(password, hash)) {
      return null;
    }

    return User.fromJson(objectIdToString(data));
  }

  Future<User> insertOne(
    JwtForm form,
  ) async {
    final data = {
      '_id': ObjectId(),
      'email': form.email,
      'password': makeHash(form.password),
    };

    await db //
        .collection(collection)
        .insertOne(data);

    return User.fromJson(objectIdToString(data));
  }

  Future<void> deleteById(
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
