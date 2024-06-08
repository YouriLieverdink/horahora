import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:horahora/config.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';

SecretKey get _key => SecretKey(passphrase);

JWT verifyJwt(String token) {
  return JWT.verify(token, _key);
}

String makeJwt(User user) {
  final jwt = JWT(
    {
      'email': user.email,
    },
    subject: user.id,
  );

  return jwt.sign(_key);
}
