import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Session extends Equatable {
  /// The unique identifier.
  final String id;

  const Session({
    required this.id,
  });

  factory Session.fromJson(
    Map<String, dynamic> json,
  ) {
    return Session(
      id: (json['_id'] as ObjectId).toHexString(),
    );
  }

  Session copyWith({
    String? id,
  }) {
    return Session(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
    };
  }

  @override
  List<Object?> get props => [id];
}
