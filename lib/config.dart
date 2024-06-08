import 'package:dotenv/dotenv.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();

String get passphrase => env.getOrElse(
      'PASSPHRASE',
      () => throw ArgumentError.notNull(),
    );
