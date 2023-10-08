import 'package:dotenv/dotenv.dart';

final env = DotEnv()..load();

String get googleEmail => env['GOOGLE_EMAIL'] ?? '';
String get googlePassword => env['GOOGLE_PASSWORD'] ?? '';
