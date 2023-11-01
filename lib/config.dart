import 'dart:io';

String get googleEmail => Platform.environment['GOOGLE_EMAIL'] ?? '';
String get googlePassword => Platform.environment['GOOGLE_PASSWORD'] ?? '';
