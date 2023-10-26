import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart' as i1;
import 'package:mongo_dart/mongo_dart.dart';

Response onRequest(
  RequestContext context,
) {
  final db = context.read<Db>();

  if (!db.isConnected) {
    return Response.json(
      body: const [
        i1.Error(
          code: 'database',
          message: 'Database is unavailable.',
        ),
      ],
      statusCode: HttpStatus.serviceUnavailable,
    );
  }

  return Response.json(
    body: const i1.Healthcheck(
      status: 'Healthy',
    ),
  );
}
