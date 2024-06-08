import 'package:dotenv/dotenv.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();

String get dbUrl => env.getOrElse(
      'DB_URL',
      () => 'mongodb://127.0.0.1/horahora',
    );
