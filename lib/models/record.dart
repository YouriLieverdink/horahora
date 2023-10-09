import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Record extends Equatable {
  /// The unique identifier.
  final String id;

  /// The start date and time.
  final DateTime start;

  /// The end date and time.
  final DateTime end;

  /// The unique identifier of the related user.
  final String userId;

  /// The unique identifier of the related job.
  final String jobId;

  /// The duration of this record.
  Duration get duration => end.difference(start);

  const Record({
    required this.id,
    required this.start,
    required this.end,
    required this.userId,
    required this.jobId,
  });

  factory Record.fromJson(
    Map<String, dynamic> json,
  ) {
    return Record(
      id: (json['_id'] as ObjectId).toHexString(),
      start: pick(json, 'start').asDateTimeOrThrow(),
      end: pick(json, 'end').asDateTimeOrThrow(),
      userId: pick(json, 'userId').asStringOrThrow(),
      jobId: pick(json, 'jobId').asStringOrThrow(),
    );
  }

  Record copyWith({
    String? id,
    DateTime? start,
    DateTime? end,
    String? userId,
    String? jobId,
  }) {
    return Record(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      userId: userId ?? this.userId,
      jobId: jobId ?? this.jobId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'userId': userId,
      'jobId': jobId,
      'meta': {
        'durationInSeconds': duration.inSeconds,
      },
    };
  }

  @override
  List<Object?> get props => [id, start, end, userId, jobId];
}
