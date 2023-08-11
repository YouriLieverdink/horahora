import 'package:hours/hours.dart';
import 'package:shelf_plus/shelf_plus.dart';

void main() => shelfRun(handler, defaultBindAddress: '0.0.0.0');
