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

  Future<User?> getUserById(
    String? id,
  ) async {
    if (id == null) {
      return null;
    }

    final id_ = ObjectId.fromHexString(id);
    final data = await db //
        .collection(collection)
        .findOne(where.id(id_));

    if (data != null) {
      return User.fromJson(objectIdToString(data));
    }

    return null;
  }

  Future<User?> getUserByCredentials(
    String email,
    String password,
  ) async {
    final data = await db //
        .collection(collection)
        .findOne(
          where.eq('email', email).eq('password', makeHash(password)),
        );

    if (data != null) {
      return User.fromJson(objectIdToString(data));
    }

    return null;
  }

  Future<User?> getUserByEmail(
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

  Future<User> insertOne(
    String email,
    String hashedPassword,
  ) async {
    final data = {
      '_id': ObjectId(),
      'email': email,
      'password': hashedPassword,
    };

    await db //
        .collection(collection)
        .insertOne(data);

    return User.fromJson(objectIdToString(data));
  }
}
