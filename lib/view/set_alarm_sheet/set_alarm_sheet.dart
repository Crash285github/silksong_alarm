library set_alarm_sheet;

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:silksong_alarm/model/alarm_notifier.dart';
import 'package:silksong_alarm/services/date_time_manager.dart';
import 'package:silksong_alarm/services/silksong_news.dart';

part 'volume_changer.dart';
part 'days_selector.dart';
part 'set_btn.dart';
part 'set_time.dart';

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
    backgroundColor: Colors.transparent,
    elevation: 0,
    builder: (context) => const _SetAlarmSheet(),
  );
}

class _SetAlarmSheet extends StatefulWidget {
  const _SetAlarmSheet();

  @override
  State<_SetAlarmSheet> createState() => _SetAlarmSheetState();
}

class _SetAlarmSheetState extends State<_SetAlarmSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (context, scrollController) => _Sheet(scrollController),
    );
  }
}

class _Sheet extends StatefulWidget {
  final ScrollController controller;
  const _Sheet(this.controller);

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> {
  DateTime dateTime = DateTime.now().copyWith(second: 0);

  bool get canSet => dateTime.isAfter(
        DateTime.now().add(
          const Duration(minutes: 1),
        ),
      );

  Future<void> _setTime() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _DaysSelector(),
          _SetTime(
            dateTime: dateTime,
            onTap: _setTime,
          ),
          const _VolumeChanger(),
          const Spacer(),
          AnimatedOpacity(
            duration: Durations.medium1,
            opacity: canSet ? 1 : .2,
            child: _SetBtn(
              onTap: canSet
                  ? () async {
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
                          volume: .1,
                        ),
                      );

                      AlarmNotifier().notify();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
