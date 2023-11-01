import 'package:csv/csv.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart';

extension RecordDuration on Record {
  Duration get duration => end.difference(start);
}

extension RecordsTotalDuration on List<Record> {
  Duration get totalDuration {
    return map((a) => a.duration)
        .fold(Duration.zero, (prev, curr) => prev + curr);
  }
}

extension RecordsCsv on List<Record> {
  String toCsv() {
    final List<List<String>> data = [
      ['start', 'end', 'duration'],
    ];

    map(
      (a) => [
        a.start.toIso8601String(),
        a.end.toIso8601String(),
        (a.duration.inMinutes / 60).toStringAsFixed(2),
      ],
    ).forEach(data.add);

    return const ListToCsvConverter().convert(data);
  }
}
