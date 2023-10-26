import 'package:csv/csv.dart';
import 'package:horahora/generated/nl_iruoy_horahora_v0_json.dart' as i1;

extension RecordDuration on i1.Record {
  Duration get duration => end.difference(start);
}

extension RecordsTotalDuration on List<i1.Record> {
  Duration get totalDuration {
    return map((a) => a.duration)
      .fold(Duration.zero, (prev, curr) => prev + curr);
  }
}

extension RecordsCsv on List<i1.Record> {
  String toCsv() {
    final List<List<String>> data = [
      ['start', 'end', 'duration'],
    ];

    map(
      (a) => [
        a.start.toIso8601String(),
        a.end.toIso8601String(),
        (a.duration.inSeconds / 3600).toStringAsFixed(2),
      ],
    ).forEach(data.add);

    return const ListToCsvConverter().convert(data);
  }
}
