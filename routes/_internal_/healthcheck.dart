import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Response onRequest(
  RequestContext context,
) {
  final db = context.read<Db>();

  if (!db.isConnected) {
    return Response(
      body: 'No database connection',
      statusCode: HttpStatus.serviceUnavailable,
    );
  }

  return Response(
    body: 'Healthy',
  );
}
