import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:silksong_alarm/silksong_news.dart';

class SetAlarm extends StatefulWidget {
  const SetAlarm({super.key});

  @override
  State<SetAlarm> createState() => _SetAlarmState();
}

class _SetAlarmState extends State<SetAlarm> {
  TimeOfDay time = const TimeOfDay(hour: 12, minute: 00);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 12, minute: 0),
              );

              setState(() => time = picked ?? time);
            },
            child: Text(
              DateFormat("HH:mm")
                  .format(DateTime(0, 0, 0, time.hour, time.minute)),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const Spacer(),
          TextButton(
            child: const Text("Set Alarm"),
            onPressed: () async {
              await Alarm.set(
                alarmSettings: AlarmSettings(
                  id: 1000,
                  dateTime: DateTime.now().copyWith(
                    hour: time.hour,
                    minute: time.minute,
                  ),
                  vibrate: true,
                  androidFullScreenIntent: true,
                  enableNotificationOnKill: true,
                  assetAudioPath: await SilksongNews.path,
                  notificationTitle: "SILKSONG NÖEWS?????",
                  notificationBody: "morning copium dose",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
