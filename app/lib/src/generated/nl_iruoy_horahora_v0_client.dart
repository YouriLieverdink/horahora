/// {@template nl_iruoy_horahora_v0_client}
/// Simple mobile application to keep track of worked hours.
/// {@endtemplate}
library nl_iruoy_horahora_v0_client;

import 'dart:convert' as _i4;
import 'dart:core' as _i2;

import 'package:http/http.dart' as _i1;

import './nl_iruoy_horahora_v0_json.dart' as _i3;

class HealthcheckResource {
  const HealthcheckResource({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  _i2.Future<_i3.Healthcheck> getHealthcheck() async {
    final uri = _i2.Uri.parse('$baseUrl/_internal_/healthcheck');

    final response = await client.get(uri);

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return _i3.Healthcheck.fromJson(json);

      case 500:
        final json = _i4.jsonDecode(response.body);

        throw (json as _i2.List).map((v0) => _i3.Error.fromJson(v0)).toList();

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }
}

class JobResource {
  const JobResource({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  _i2.Future<_i2.List<_i3.Job>> get() async {
    final uri = _i2.Uri.parse('$baseUrl/jobs');

    final response = await client.get(uri);

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return (json as _i2.List).map((v0) => _i3.Job.fromJson(v0)).toList();

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }

  _i2.Future<_i3.Job> post(_i3.JobForm body) async {
    final uri = _i2.Uri.parse('$baseUrl/jobs');

    final response = await client.post(
      uri,
      body: _i4.jsonEncode(body),
    );

    switch (response.statusCode) {
      case 201:
        final json = _i4.jsonDecode(response.body);

        return _i3.Job.fromJson(json);

      case 400:
        final json = _i4.jsonDecode(response.body);

        throw (json as _i2.List).map((v0) => _i3.Error.fromJson(v0)).toList();

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }

  _i2.Future<_i3.Job> putById(
    _i3.JobForm body, {
    required _i2.String id,
  }) async {
    final uri = _i2.Uri.parse('$baseUrl/jobs/$id');

    final response = await client.put(
      uri,
      body: _i4.jsonEncode(body),
    );

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return _i3.Job.fromJson(json);

      case 400:
        final json = _i4.jsonDecode(response.body);

        throw (json as _i2.List).map((v0) => _i3.Error.fromJson(v0)).toList();

      case 404:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }

  _i2.Future<void> deleteById({required _i2.String id}) async {
    final uri = _i2.Uri.parse('$baseUrl/jobs/$id');

    final response = await client.delete(uri);

    switch (response.statusCode) {
      case 204:
        break;

      case 404:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }
}

class RecordResource {
  const RecordResource({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  _i2.Future<_i2.List<_i3.Record>> getByFromAndTo({
    required _i2.String from,
    required _i2.String to,
    _i2.String? jobId,
  }) async {
    final query = {'jobId': jobId?.toString()};

    final uri = _i2.Uri.parse('$baseUrl/records/$from/$to')
        .replace(queryParameters: query);

    final response = await client.get(uri);

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return (json as _i2.List).map((v0) => _i3.Record.fromJson(v0)).toList();

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }

  _i2.Future<_i3.Record> post(_i3.RecordForm body) async {
    final uri = _i2.Uri.parse('$baseUrl/records');

    final response = await client.post(
      uri,
      body: _i4.jsonEncode(body),
    );

    switch (response.statusCode) {
      case 201:
        final json = _i4.jsonDecode(response.body);

        return _i3.Record.fromJson(json);

      case 400:
        final json = _i4.jsonDecode(response.body);

        throw (json as _i2.List).map((v0) => _i3.Error.fromJson(v0)).toList();

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }
}

class SessionResource {
  const SessionResource({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  _i2.Future<_i2.List<_i3.Session>> get() async {
    final uri = _i2.Uri.parse('$baseUrl/sessions');

    final response = await client.get(uri);

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return (json as _i2.List)
            .map((v0) => _i3.Session.fromJson(v0))
            .toList();

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }

  _i2.Future<_i3.Session> postStart(_i3.SessionForm body) async {
    final uri = _i2.Uri.parse('$baseUrl/sessions/start');

    final response = await client.post(
      uri,
      body: _i4.jsonEncode(body),
    );

    switch (response.statusCode) {
      case 201:
        final json = _i4.jsonDecode(response.body);

        return _i3.Session.fromJson(json);

      case 404:
        final json = _i4.jsonDecode(response.body);

        throw (json as _i2.List).map((v0) => _i3.Error.fromJson(v0)).toList();

      case 409:
        final json = _i4.jsonDecode(response.body);

        throw (json as _i2.List).map((v0) => _i3.Error.fromJson(v0)).toList();

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }

  _i2.Future<_i3.Session> postStop(_i3.SessionForm body) async {
    final uri = _i2.Uri.parse('$baseUrl/sessions/stop');

    final response = await client.post(
      uri,
      body: _i4.jsonEncode(body),
    );

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return _i3.Session.fromJson(json);

      case 404:
        final json = _i4.jsonDecode(response.body);

        throw (json as _i2.List).map((v0) => _i3.Error.fromJson(v0)).toList();

      case 409:
        final json = _i4.jsonDecode(response.body);

        throw (json as _i2.List).map((v0) => _i3.Error.fromJson(v0)).toList();

      default:
        throw ClientErrorResponse(
          status: response.statusCode,
          body: response.body,
        );
    }
  }
}

class Client {
  const Client({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  HealthcheckResource get healthchecks {
    return HealthcheckResource(
      client: client,
      baseUrl: baseUrl,
    );
  }

  JobResource get jobs {
    return JobResource(
      client: client,
      baseUrl: baseUrl,
    );
  }

  RecordResource get records {
    return RecordResource(
      client: client,
      baseUrl: baseUrl,
    );
  }

  SessionResource get sessions {
    return SessionResource(
      client: client,
      baseUrl: baseUrl,
    );
  }
}

class ClientErrorResponse implements _i2.Exception {
  const ClientErrorResponse({
    required this.status,
    required this.body,
  });

  final _i2.int status;

  final _i2.dynamic body;
}
