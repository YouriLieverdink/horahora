import 'package:automatons/models/user.dart';
import 'package:automatons/repositories/session.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Handler middleware(
  Handler handler,
) {
  return (context) async {
    final db = context.read<Db>();
    final user = context.read<User>();

    return handler //
        .use(provider((_) => SessionRepo(db: db, user: user)))
        .call(context);
  };
}
