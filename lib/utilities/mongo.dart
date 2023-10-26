import 'package:mongo_dart/mongo_dart.dart';

/// Maps the [_id] field from an [ObjectId] into a [String].
Map<String, dynamic> objectIdToString(Map<String, dynamic> data) {
  data.update(
    '_id',
    (currentValue) {
      final id = currentValue as ObjectId;

      return id.toHexString();
    },
  );

  return data;
}
