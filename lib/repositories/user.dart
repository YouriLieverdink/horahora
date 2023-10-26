import 'package:horahora/utilities/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../generated/nl_iruoy_horahora_v0_json.dart' as i1;

const collection = 'users';

class UserRepo {
  final Db db;

  const UserRepo({
    required this.db,
  });

  Future<i1.User?> getUserByToken(
    String token,
  ) async {
    final data = await db //
        .collection(collection)
        .findOne(where.eq('token', token));

    if (data != null) {
      return i1.User.fromJson(objectIdToString(data));
    }

    return null;
  }
}
