import 'dart:convert';

import 'package:crypto/crypto.dart';

String makeHash(String value) {
  final bytes = utf8.encode(value);
  final digest = sha256.convert(bytes);

  return digest.toString();
}

bool compareHash(String value, String hash) {
  return makeHash(value) == hash;
}
