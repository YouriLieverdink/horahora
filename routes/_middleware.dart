import 'package:automatons/domain/domain.dart';
import 'package:automatons/repositories/user.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(
  Handler handler,
) {
  return (context) async {
    await db.open();

    final response = await handler //
        .use(requestLogger())
        .use(provider((_) => db))
        .use(provider((_) => UserRepo(db: db)))
        .call(context);

    await db.close();

    return response;
  };
}
