import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/alarm_notifier.dart';

class AlarmList extends StatelessWidget {
  final List<AlarmSettings> alarms;

  const AlarmList({super.key, required this.alarms});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AlarmNotifier(),
      builder: (context, child) => ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (context, index) => InkWell(
          child: Card(
            child: Text(alarms[index].dateTime.toString()),
          ),
        ),
      ),
    );
  }
}
