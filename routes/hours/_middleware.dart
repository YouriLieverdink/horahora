import 'package:automatons/providers/job_repo.dart';
import 'package:automatons/providers/record_repo.dart';
import 'package:automatons/providers/session_repo.dart';
import 'package:automatons/repositories/user.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';

Handler middleware(
  Handler handler,
) {
  return (context) async {
    final userRepo = context.read<UserRepo>();

    final middleware = bearerAuthentication(
      userFromToken: userRepo.getUserByToken,
    );

    return handler //
        .use(jobRepoProvider())
        .use(recordRepoProvider())
        .use(sessionRepoProvider())
        .use(middleware)
        .call(context);
  };
}
