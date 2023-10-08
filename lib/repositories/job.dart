import 'package:automatons/models/job.dart';
import 'package:automatons/models/user.dart';
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

    if (data != null ) {
      return Job.fromJson(data);
    }

    return null;
  }

  Future<Job> insertOne(
    String name,
  ) async {
    final data = {
      '_id': ObjectId(),
      'name': name,
      'userId': user.id,
    };

    await db //
        .collection(collection)
        .insertOne(data);

    return Job.fromJson(data);
  }

  Future<Job> updateById(
    String id,
    String name,
  ) async {
    final data = {
      'name': name,
    };

    await db //
        .collection(collection)
        .replaceOne(
          where.id(
            ObjectId.fromHexString(id),
          ),
          data,
        );

    return Job(id: id, name: name);
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
