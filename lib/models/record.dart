import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Record extends Equatable {
  final ObjectId id;
  final DateTime start;
  final DateTime? end;
  final String userId;

  const Record({
    required this.id,
    required this.start,
    required this.end,
    required this.userId,
  });

  factory Record.fromDocument(Map<String, dynamic> json) {
    return Record(
      id: json['_id'] as ObjectId,
      start: DateTime.parse(json['start'] as String),
      end: json['end'] != null //
          ? DateTime.parse(json['end'] as String)
          : null,
      userId: json['userId'] as String,
    );
  }

  Record copyWith({
    ObjectId? id,
    DateTime? start,
    DateTime? end,
    String? userId,
  }) {
    return Record(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      '_id': id,
      'start': start.toIso8601String(),
      'end': end?.toIso8601String(),
      'userId': userId,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'start': start.toIso8601String(),
      'end': end?.toIso8601String(),
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [id, start, end, userId];
}
