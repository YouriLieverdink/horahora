import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User extends Equatable {
  /// The unique identifier.
  final String id;

  /// The token used to access the api.
  final String token;

  const User({
    required this.id,
    required this.token,
  });

  factory User.fromJson(
    Map<String, dynamic> json,
  ) {
    return User(
      id: (json['_id'] as ObjectId).toHexString(),
      token: pick(json, 'token').asStringOrThrow(),
    );
  }

  User copyWith({
    String? id,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'token': token,
    };
  }

  @override
  List<Object?> get props => [id, token];
}
