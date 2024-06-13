import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/utilities/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart';

const collection = 'hours-jobs';

class JobRepo {
  final Db db;
  final User user;

  const JobRepo({
    required this.db,
    required this.user,
  });

  Future<List<Job>> findAll() async {
    final data = await db //
        .collection(collection)
        .find()
        .toList();

    return data //
        .map(objectIdToString)
        .map(Job.fromJson)
        .toList();
  }

  Future<Job?> findById(
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
      return Job.fromJson(objectIdToString(data));
    }

    return null;
  }

  Future<Job> insertOne(
    JobForm form,
  ) async {
    final data = {
      '_id': ObjectId(),
      'name': form.name,
      'userId': user.id,
    };

    await db //
        .collection(collection)
        .insertOne(data);

    return Job.fromJson(objectIdToString(data));
  }

  Future<Job> updateById(
    String id,
    JobForm form,
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

    return Job(id: id, name: form.name);
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

  Future<void> deleteAllByUser(
    String userId,
  ) async {
    await db //
        .collection(collection)
        .deleteMany(
          where.eq('userId', userId),
        );
  }
}
