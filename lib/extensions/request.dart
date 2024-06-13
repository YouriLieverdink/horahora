import 'package:dart_frog/dart_frog.dart';

extension Authorization on Request {
  String? authorization(
    String type,
  ) {
    final value = headers['Authorization']?.split(' ');

    if (value != null && value.length == 2 && value.first == type) {
      return value.last;
    }

    return null;
  }

  String? bearer() => authorization('Bearer');
}
