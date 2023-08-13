import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User extends Equatable {
  final ObjectId id;

  const User({
    required this.id,
  });

  factory User.fromDocument(
    Map<String, dynamic> document,
  ) {
    return User(
      id: document['_id'] as ObjectId,
    );
  }

  User copyWith({
    ObjectId? id,
  }) {
    return User(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      '_id': id,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
    };
  }

  @override
  List<Object?> get props => [id];
}
