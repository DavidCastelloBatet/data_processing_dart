import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart totals.dart <inputFile.csv');
    exit(1);
  }
  final inputFile = arguments.first;
  final lines = File(inputFile).readAsLinesSync();
  final totalDurationByTag = <String, double>{};
  lines.removeAt(0);
  for (var line in lines) {
    final values = line.split(',');
    final durationStr = values[3].replaceAll('"', '');
    final duration = double.parse(durationStr);
    //final duration = double.parse(values[3]);
    final tag = values[5].replaceAll('"', '');
    final previousTotal = totalDurationByTag[tag];
    previousTotal == null
        ? totalDurationByTag[tag] = duration
        : totalDurationByTag[tag] = previousTotal + duration;
  }
  for (var entry in totalDurationByTag.entries) {
    final durationFormated = entry.value.toStringAsFixed(1);
    final tag = entry.key;
    print('$tag :  $durationFormated hours');
  }
}
