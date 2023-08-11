import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:test/test.dart';

import '../../routes/_internal_/healthcheck.dart' as route;

class MockRequestContext extends Mock implements RequestContext {}

class MockDb extends Mock implements Db {}

void main() {
  final context = MockRequestContext();
  final db = MockDb();

  when(() => context.read<Db>()).thenReturn(db);

  group(
    'GET /_internal_/healthcheck',
    () {
      test(
        'returns 200 healthy',
        () {
          when(() => db.isConnected).thenReturn(true);

          final response = route.onRequest(context);

          expect(response.statusCode, equals(HttpStatus.ok));
        },
      );

      test(
        'returns 503 unhealthy when database is not connected',
        () {
          when(() => db.isConnected).thenReturn(false);

          final response = route.onRequest(context);

          expect(response.statusCode, equals(HttpStatus.serviceUnavailable));
        },
      );
    },
  );
}
