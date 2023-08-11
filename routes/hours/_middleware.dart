import 'package:automatons/repositories/user_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:mongo_dart/mongo_dart.dart';

Handler middleware(
  Handler handler,
) {
  return (context) async {
    final db = context.read<Db>();
    final userRepository = UserRepository(db: db);

    final middleware = bearerAuthentication(
      userFromToken: userRepository.getUserByToken,
    );

    return handler //
        .use(middleware)
        .call(context);
  };
}
