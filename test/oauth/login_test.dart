import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';
import 'package:horahora/repositories/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/oauth/login.dart' as route;

class MockRequestContext extends Mock implements RequestContext {}

class MockRequest extends Mock implements Request {}

class MockUserRepo extends Mock implements UserRepo {}

const mockJwtForm = JwtForm(email: 'shaun@sheep.barn', password: 'grass');
const mockUser = User(id: '1', email: 'shaun@sheep.barn');

void main() {
  final context = MockRequestContext();
  final request = MockRequest();
  final userRepo = MockUserRepo();

  when(() => context.request) //
      .thenReturn(request);

  when(() => request.method) //
      .thenReturn(HttpMethod.post);
  when(() => request.json()) //
      .thenAnswer((_) async => mockJwtForm.toJson());

  when(() => context.read<UserRepo>()) //
      .thenReturn(userRepo);

  when(
    () => userRepo.findUserByCredentials(
      mockJwtForm.email,
      mockJwtForm.password,
    ),
  ).thenAnswer((_) async => mockUser);

  group(
    'POST /oauth/login',
    () {
      test(
        'returns 200 on success',
        () async {
          final response = await route.onRequest(context);

          expect(response.statusCode, equals(HttpStatus.ok));
        },
      );

      test(
        'returns a JWT token on success',
        () async {
          final response = await route.onRequest(context);
          final json = await response.json();

          final jwt = Jwt.fromJson(json);

          expect(JWT.decode(jwt.token), isNotNull);
        },
      );

      test(
        'returns 401 when credentials are incorrect',
        () async {
          when(
            () => userRepo.findUserByCredentials(
              mockJwtForm.email,
              mockJwtForm.password,
            ),
          ).thenAnswer((_) async => null);

          final response = await route.onRequest(context);

          expect(response.statusCode, equals(HttpStatus.unauthorized));
        },
      );
    },
  );
}
