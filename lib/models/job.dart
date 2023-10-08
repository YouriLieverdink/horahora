import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Job extends Equatable {
  /// The unique identifier.
  final String id;

  /// The name of this job.
  final String name;

  const Job({
    required this.id,
    required this.name,
  });

  factory Job.fromJson(
    Map<String, dynamic> json,
  ) {
    return Job(
      id: (json['_id'] as ObjectId).toHexString(),
      name: pick(json, 'name').asStringOrThrow(),
    );
  }

  Job copyWith({
    String? id,
    String? name,
  }) {
    return Job(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
