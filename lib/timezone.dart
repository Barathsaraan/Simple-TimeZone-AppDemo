import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class YourWidget extends StatelessWidget {
  final DateTime createdAt;

  const YourWidget({super.key, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timezone Demo')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Created (Local): ${_formatDateTime(createdAt, null)}',
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            'US (New York): ${_formatDateTime(createdAt, 'America/New_York')}',
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            'UK (London): ${_formatDateTime(createdAt, 'Europe/London')}',
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            'Australia (Sydney): ${_formatDateTime(createdAt, 'Australia/Sydney')}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime, String? timeZone) {
    tz.initializeTimeZones();
    final location = timeZone != null ? tz.getLocation(timeZone) : tz.local;
    final tzDateTime = tz.TZDateTime.from(dateTime.toUtc(), location);
    final formatter = DateFormat('dd/MM/yyyy HH:mm:ss z');
    return formatter.format(tzDateTime);
  }
}
void testTimeZones() {
  final testDateTime =
      DateTime.utc(2024, 9, 28, 12, 0, 0); 
  final widget = YourWidget(createdAt: testDateTime);
  print('Test DateTime (UTC): $testDateTime');
  print('Local: ${widget._formatDateTime(testDateTime, null)}');
  print(
      'US (New York): ${widget._formatDateTime(testDateTime, 'America/New_York')}');
  print(
      'UK (London): ${widget._formatDateTime(testDateTime, 'Europe/London')}');
  print(
      'Australia (Sydney): ${widget._formatDateTime(testDateTime, 'Australia/Sydney')}');
}
