import 'package:automatons/models.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:mongo_dart/mongo_dart.dart';

Handler middleware(Handler handler) {
  //
  Future<User?> getUserByToken(Db db, String token) async {
    try {
      final id = ObjectId.parse(token);
      final document = await db //
          .collection('users')
          .findOne(where.id(id));

      if (document != null) {
        return User.fromDocument(document);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  return (context) async {
    final db = context.read<Db>();

    final handler_ = handler.use(
      bearerAuthentication<User>(
        userFromToken: (token) => getUserByToken(db, token),
      ),
    );

    return handler_(context);
  };
}
