import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/alarm_notifier.dart';
import 'package:silksong_alarm/services/silksong_news.dart';

class SetAlarmButton extends StatelessWidget {
  const SetAlarmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async => await _setAlarm(context),
      child: const Icon(Icons.alarm_add),
    );
  }
}

Future<void> _setAlarm(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    useSafeArea: true,
    builder: (context) => const _SetAlarmSheet(),
  );
}

class _SetAlarmSheet extends StatefulWidget {
  const _SetAlarmSheet();

  @override
  State<_SetAlarmSheet> createState() => _SetAlarmSheetState();
}

class _SetAlarmSheetState extends State<_SetAlarmSheet> {
  DateTime dateTime = DateTime.now()
      .add(
        const Duration(minutes: 5),
      )
      .copyWith(second: 0);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (context, scrollController) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              controller: scrollController,
              children: [
                Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () async {
                      final selected = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (selected != null) {
                        DateTime time = DateTime.now().copyWith(
                          hour: selected.hour,
                          minute: selected.minute,
                          second: 0,
                        );

                        if (time.isBefore(DateTime.now())) {
                          time = time.add(const Duration(days: 1));
                        }

                        setState(() => dateTime = time);

                        AlarmNotifier().notify();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Time:\n${dateTime.toString().split('.')[0]}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () async {
                await Alarm.set(
                  alarmSettings: AlarmSettings(
                    id: DateTime.now().millisecondsSinceEpoch % 100000,
                    dateTime: dateTime,
                    assetAudioPath: await SilksongNews.path,
                    notificationTitle: "Your Daily Silksong Alarm",
                    notificationBody: "There has been... ???",
                    androidFullScreenIntent: true,
                    enableNotificationOnKill: true,
                    vibrate: true,
                    volume: 0.1,
                  ),
                );

                AlarmNotifier().notify();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Save",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
