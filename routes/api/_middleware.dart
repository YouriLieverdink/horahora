import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/middleware/jwt.dart';
import 'package:horahora/providers/job_repo.dart';
import 'package:horahora/providers/record_repo.dart';
import 'package:horahora/providers/session_repo.dart';
import 'package:horahora/repositories/user.dart';

Handler middleware(
  Handler handler,
) {
  return (context) async {
    final userRepo = context.read<UserRepo>();

    final middleware = jwt(
      getUserById: userRepo.getUserById,
    );

    return handler //
        .use(jobRepoProvider())
        .use(recordRepoProvider())
        .use(sessionRepoProvider())
        .use(middleware)
        .call(context);
  };
}
