import 'package:shelf_plus/shelf_plus.dart';

Handler handler() {
  final handler = RouterPlus();

  handler.use(setContentType('application/json'));
  handler.use(logRequests());

  handler.get('/_internal_/healthcheck', () => 'Healthy :)');

  return handler.call;
}
