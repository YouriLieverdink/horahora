import 'package:horahora/utilities/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../generated/nl_iruoy_horahora_v0_json.dart' as i1;

const collection = 'hours-jobs';

class JobRepo {
  final Db db;
  final i1.User user;

  const JobRepo({
    required this.db,
    required this.user,
  });

  Future<List<i1.Job>> findAll() async {
    final data = await db //
        .collection(collection)
        .find()
        .toList();

    return data //
        .map(objectIdToString)
        .map(i1.Job.fromJson)
        .toList();
  }

  Future<i1.Job?> findById(
    String id,
  ) async {
    if (!ObjectId.isValidHexId(id)) {
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
      return i1.Job.fromJson(objectIdToString(data));
    }

    return null;
  }

  Future<i1.Job> insertOne(
    i1.JobForm form,
  ) async {
    final data = {
      '_id': ObjectId(),
      'name': form.name,
      'userId': user.id,
    };

    await db //
        .collection(collection)
        .insertOne(data);

    return i1.Job.fromJson(objectIdToString(data));
  }

  Future<i1.Job> updateById(
    String id,
    i1.JobForm form,
  ) async {
    final data = {
      'name': form.name,
    };

    await db //
        .collection(collection)
        .replaceOne(
          where.id(
            ObjectId.fromHexString(id),
          ),
          data,
        );

    return i1.Job(id: id, name: form.name);
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
