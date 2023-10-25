import 'package:csv/csv.dart';
import 'package:horahora/models/record.dart';

String recordsToCsv(
  List<Record> records,
) {
  final List<List<String>> data = [
    ['start', 'end', 'duration'],
  ];

  records //
      .map(
        (a) => [
          a.start.toIso8601String(),
          a.end.toIso8601String(),
          (a.duration.inSeconds / 3600).toStringAsFixed(2),
        ],
      )
      .forEach(data.add);

  return const ListToCsvConverter().convert(data);
}

String totalDurationInHours(
  List<Record> records,
) {
  return records //
      .map((a) => a.duration.inSeconds)
      .map((b) => b / 3600)
      .fold(0.0, (prev, curr) => prev + curr)
      .toStringAsFixed(2);
}
