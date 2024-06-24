import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';

class AlarmList extends StatelessWidget {
  final List<AlarmSettings> alarms;

  const AlarmList({super.key, required this.alarms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: alarms.length,
      itemBuilder: (context, index) => InkWell(
        child: Card(
          child: Text(alarms[index].notificationTitle),
        ),
      ),
    );
  }
}
