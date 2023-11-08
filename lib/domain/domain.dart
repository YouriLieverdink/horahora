import 'dart:io';

import 'package:horahora/config.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mongo_dart/mongo_dart.dart';

const localDbUrl = 'mongodb://127.0.0.1/horahora';

final dbUrl = Platform.environment['dbUrl'];
final db = Db(dbUrl ?? localDbUrl);

final smtp = gmail(googleEmail, googlePassword);
