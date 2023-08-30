import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Session extends Equatable {
  /// The unique identifier.
  final String id;

  /// The start date and time.
  final DateTime start;

  const Session({
    required this.id,
    required this.start,
  });

  factory Session.fromJson(
    Map<String, dynamic> json,
  ) {
    return Session(
      id: (json['_id'] as ObjectId).toHexString(),
      start: pick(json, 'start').asDateTimeOrThrow(),
    );
  }

  Session copyWith({
    String? id,
    DateTime? start,
  }) {
    return Session(
      id: id ?? this.id,
      start: start ?? this.start,
    );
  }

  Map<String, dynamic> toJson() {
    final now = DateTime.now();

    return {
      '_id': id,
      'start': start.toIso8601String(),
      'meta': {
        'duration': now.difference(start).inSeconds,
      },
    };
  }

  @override
  List<Object?> get props => [id, start];
}
