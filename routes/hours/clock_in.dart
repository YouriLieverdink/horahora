import 'package:automatons/models.dart';
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final user = context.read<User>();

  return Response(body: 'User: ${user.id}');
}
