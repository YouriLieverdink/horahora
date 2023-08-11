import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/_internal_/healthcheck.dart' as route;

class MockRequestContext extends Mock implements RequestContext {}

void main() {
  group(
    'GET /_internal_/healthcheck',
    () {
      test(
        'responds with healthy and status ok',
        () async {
          final context = MockRequestContext();

          final response = route.onRequest(context);

          expect(response.statusCode, equals(HttpStatus.ok));
          expect(response.body(), completion(equals('Healthy')));
        },
      );
    },
  );
}
