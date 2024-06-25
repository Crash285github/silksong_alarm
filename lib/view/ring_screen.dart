import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/alarm_notifier.dart';

class RingScreen extends StatelessWidget {
  final AlarmSettings alarmSettings;
  const RingScreen({
    super.key,
    required this.alarmSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Silksong News???"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  Alarm.set(
                    alarmSettings: alarmSettings.copyWith(
                      dateTime: DateTime.now().add(
                        const Duration(minutes: 5),
                      ),
                    ),
                  ).whenComplete(
                    () => AlarmNotifier().notify(),
                  );

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.snooze),
                label: const Text("Snooze (5min)"),
              ),
              TextButton.icon(
                onPressed: () {
                  Alarm.stop(alarmSettings.id).whenComplete(
                    () => AlarmNotifier().notify(),
                  );

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.alarm_off),
                label: const Text("Stop"),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
