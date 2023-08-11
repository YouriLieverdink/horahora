import 'package:mongo_dart/mongo_dart.dart';

class User {
  final String id;

  const User({
    required this.id,
  });

  factory User.fromDocument(
    Map<String, dynamic> document,
  ) {
    return User(
      id: (document['_id'] as ObjectId).$oid,
    );
  }
}
