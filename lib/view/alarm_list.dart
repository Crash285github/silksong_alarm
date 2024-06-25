import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/alarm_notifier.dart';
import 'package:silksong_alarm/model/persistence.dart';

class AlarmList extends StatelessWidget {
  const AlarmList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AlarmNotifier(),
      builder: (context, child) => ListView.builder(
        itemCount: Persistence.alarms.length,
        itemBuilder: (context, index) => InkWell(
          child: Card(
            child: InkWell(
              onTap: () async {
                await Alarm.stop(Persistence.alarms[index].id);

                AlarmNotifier().notify();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Persistence.alarms[index].dateTime.toString(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
