import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Session extends Equatable {
  /// The unique identifier.
  final String id;

  /// The start date and time.
  final DateTime start;

  /// The unique identifier of the related user.
  final String userId;

  /// The unique identifier of the related job.
  final String jobId;

  const Session({
    required this.id,
    required this.start,
    required this.userId,
    required this.jobId,
  });

  factory Session.fromJson(
    Map<String, dynamic> json,
  ) {
    return Session(
      id: (json['_id'] as ObjectId).toHexString(),
      start: pick(json, 'start').asDateTimeOrThrow(),
      userId: pick(json, 'userId').asStringOrThrow(),
      jobId: pick(json, 'jobId').asStringOrThrow(),
    );
  }

  Session copyWith({
    String? id,
    DateTime? start,
    String? userId,
    String? jobId,
  }) {
    return Session(
      id: id ?? this.id,
      start: start ?? this.start,
      userId: userId ?? this.userId,
      jobId: jobId ?? this.jobId,
    );
  }

  Map<String, dynamic> toJson() {
    final now = DateTime.now();

    return {
      '_id': id,
      'start': start.toIso8601String(),
      'userId': userId,
      'jobId': jobId,
      'meta': {
        'duration': now.difference(start).inSeconds,
      },
    };
  }

  @override
  List<Object?> get props => [id, start, userId, jobId];
}
