import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';

const localDbUrl = 'mongodb://127.0.0.1/automatons';

final dbUrl = Platform.environment['dbUrl'];
final db = Db(dbUrl ?? localDbUrl);
