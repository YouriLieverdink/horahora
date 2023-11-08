import 'package:dotenv/dotenv.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();

String get googleEmail => env['GOOGLE_EMAIL'] ?? '';
String get googlePassword => env['GOOGLE_PASSWORD'] ?? '';
String get appName => env['APP_NAME'] ?? 'Horahora';
