/// {@template nl_iruoy_horahora_v0_json}
/// Simple mobile application to keep track of worked hours.
/// {@endtemplate}
library nl_iruoy_horahora_v0_json;

import 'dart:core' as _i2;

import 'package:equatable/equatable.dart' as _i1;

class Error extends _i1.Equatable {
  const Error({
    required this.code,
    required this.message,
  });

  factory Error.fromJson(_i2.dynamic json) {
    return Error(
      code: (json['code'] as _i2.String),
      message: (json['message'] as _i2.String),
    );
  }

  final _i2.String code;

  final _i2.String message;

  _i2.dynamic toJson() {
    return {'code': code, 'message': message};
  }

  Error copyWith({
    _i2.String? code,
    _i2.String? message,
  }) {
    return Error(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [code, message];
  }
}

class Export extends _i1.Equatable {
  const Export();

  factory Export.fromJson(_i2.dynamic json) {
    return Export();
  }

  _i2.dynamic toJson() {
    return {};
  }

  Export copyWith() {
    return Export();
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [];
  }
}

class Healthcheck extends _i1.Equatable {
  const Healthcheck({required this.status});

  factory Healthcheck.fromJson(_i2.dynamic json) {
    return Healthcheck(status: (json['status'] as _i2.String));
  }

  final _i2.String status;

  _i2.dynamic toJson() {
    return {'status': status};
  }

  Healthcheck copyWith({_i2.String? status}) {
    return Healthcheck(status: status ?? this.status);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [status];
  }
}

class Job extends _i1.Equatable {
  const Job({
    required this.id,
    required this.name,
  });

  factory Job.fromJson(_i2.dynamic json) {
    return Job(
      id: (json['_id'] as _i2.String),
      name: (json['name'] as _i2.String),
    );
  }

  final _i2.String id;

  final _i2.String name;

  _i2.dynamic toJson() {
    return {'_id': id, 'name': name};
  }

  Job copyWith({
    _i2.String? id,
    _i2.String? name,
  }) {
    return Job(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [id, name];
  }
}

class JobForm extends _i1.Equatable {
  const JobForm({required this.name});

  factory JobForm.fromJson(_i2.dynamic json) {
    return JobForm(name: (json['name'] as _i2.String));
  }

  final _i2.String name;

  _i2.dynamic toJson() {
    return {'name': name};
  }

  JobForm copyWith({_i2.String? name}) {
    return JobForm(name: name ?? this.name);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name];
  }
}

class Jwt extends _i1.Equatable {
  const Jwt({required this.token});

  factory Jwt.fromJson(_i2.dynamic json) {
    return Jwt(token: (json['token'] as _i2.String));
  }

  final _i2.String token;

  _i2.dynamic toJson() {
    return {'token': token};
  }

  Jwt copyWith({_i2.String? token}) {
    return Jwt(token: token ?? this.token);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [token];
  }
}

class JwtForm extends _i1.Equatable {
  const JwtForm({
    required this.email,
    required this.password,
  });

  factory JwtForm.fromJson(_i2.dynamic json) {
    return JwtForm(
      email: (json['email'] as _i2.String),
      password: (json['password'] as _i2.String),
    );
  }

  final _i2.String email;

  final _i2.String password;

  _i2.dynamic toJson() {
    return {'email': email, 'password': password};
  }

  JwtForm copyWith({
    _i2.String? email,
    _i2.String? password,
  }) {
    return JwtForm(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [email, password];
  }
}

class Record extends _i1.Equatable {
  const Record({
    required this.id,
    required this.start,
    required this.end,
    required this.userId,
    required this.jobId,
  });

  factory Record.fromJson(_i2.dynamic json) {
    return Record(
      id: (json['_id'] as _i2.String),
      start: _i2.DateTime.parse((json['start'] as _i2.String)),
      end: _i2.DateTime.parse((json['end'] as _i2.String)),
      userId: (json['userId'] as _i2.String),
      jobId: (json['jobId'] as _i2.String),
    );
  }

  final _i2.String id;

  final _i2.DateTime start;

  final _i2.DateTime end;

  final _i2.String userId;

  final _i2.String jobId;

  _i2.dynamic toJson() {
    return {
      '_id': id,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'userId': userId,
      'jobId': jobId
    };
  }

  Record copyWith({
    _i2.String? id,
    _i2.DateTime? start,
    _i2.DateTime? end,
    _i2.String? userId,
    _i2.String? jobId,
  }) {
    return Record(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      userId: userId ?? this.userId,
      jobId: jobId ?? this.jobId,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [id, start, end, userId, jobId];
  }
}

class RecordForm extends _i1.Equatable {
  const RecordForm({
    required this.start,
    required this.end,
    required this.jobId,
  });

  factory RecordForm.fromJson(_i2.dynamic json) {
    return RecordForm(
      start: _i2.DateTime.parse((json['start'] as _i2.String)),
      end: _i2.DateTime.parse((json['end'] as _i2.String)),
      jobId: (json['jobId'] as _i2.String),
    );
  }

  final _i2.DateTime start;

  final _i2.DateTime end;

  final _i2.String jobId;

  _i2.dynamic toJson() {
    return {
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'jobId': jobId
    };
  }

  RecordForm copyWith({
    _i2.DateTime? start,
    _i2.DateTime? end,
    _i2.String? jobId,
  }) {
    return RecordForm(
      start: start ?? this.start,
      end: end ?? this.end,
      jobId: jobId ?? this.jobId,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [start, end, jobId];
  }
}

class Session extends _i1.Equatable {
  const Session({
    required this.id,
    required this.start,
    required this.userId,
    required this.jobId,
  });

  factory Session.fromJson(_i2.dynamic json) {
    return Session(
      id: (json['_id'] as _i2.String),
      start: _i2.DateTime.parse((json['start'] as _i2.String)),
      userId: (json['userId'] as _i2.String),
      jobId: (json['jobId'] as _i2.String),
    );
  }

  final _i2.String id;

  final _i2.DateTime start;

  final _i2.String userId;

  final _i2.String jobId;

  _i2.dynamic toJson() {
    return {
      '_id': id,
      'start': start.toIso8601String(),
      'userId': userId,
      'jobId': jobId
    };
  }

  Session copyWith({
    _i2.String? id,
    _i2.DateTime? start,
    _i2.String? userId,
    _i2.String? jobId,
  }) {
    return Session(
      id: id ?? this.id,
      start: start ?? this.start,
      userId: userId ?? this.userId,
      jobId: jobId ?? this.jobId,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [id, start, userId, jobId];
  }
}

class SessionForm extends _i1.Equatable {
  const SessionForm({required this.jobId});

  factory SessionForm.fromJson(_i2.dynamic json) {
    return SessionForm(jobId: (json['jobId'] as _i2.String));
  }

  final _i2.String jobId;

  _i2.dynamic toJson() {
    return {'jobId': jobId};
  }

  SessionForm copyWith({_i2.String? jobId}) {
    return SessionForm(jobId: jobId ?? this.jobId);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [jobId];
  }
}

class User extends _i1.Equatable {
  const User({
    required this.id,
    required this.email,
  });

  factory User.fromJson(_i2.dynamic json) {
    return User(
      id: (json['_id'] as _i2.String),
      email: (json['email'] as _i2.String),
    );
  }

  final _i2.String id;

  final _i2.String email;

  _i2.dynamic toJson() {
    return {'_id': id, 'email': email};
  }

  User copyWith({
    _i2.String? id,
    _i2.String? email,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [id, email];
  }
}
