library set_alarm_sheet;

import 'dart:ui';

import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:silksong_alarm/model/alarm.dart';
import 'package:silksong_alarm/services/alarm_storage_vm.dart';
import 'package:silksong_alarm/services/date_time_manager.dart';
import 'package:silksong_alarm/model/news_background_worker/silksong_news.dart';
import 'package:silksong_alarm/view/widget/beveled_card.dart';
import 'package:volume_controller/volume_controller.dart';

part 'backdrop_gradient.dart';

part 'set_volume.dart';
part 'days_selector.dart';
part 'set_btn.dart';
part 'set_time.dart';

Future<void> showSetAlarmBottomSheet(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (context, scrollController) =>
          _AlarmSetterBottomSheet(scrollController),
    ),
  );
}

class _AlarmSetterBottomSheet extends StatefulWidget {
  final ScrollController controller;
  const _AlarmSetterBottomSheet(this.controller);

  @override
  State<_AlarmSetterBottomSheet> createState() =>
      _AlarmSetterBottomSheetState();
}

class _AlarmSetterBottomSheetState extends State<_AlarmSetterBottomSheet> {
  DateTime dateTime = DateTime.now().copyWith(second: 0);
  double volume = .5;

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
    }
  }

  Future<void> _setAlarm() async {
    await AlarmStorageVM().add(
      Alarm(
        days: {},
        settings: AlarmSettings(
          id: DateTime.now().millisecondsSinceEpoch % 100000,
          dateTime: dateTime,
          assetAudioPath: await SilksongNews.path,
          notificationTitle: "Your Daily Silksong Alarm",
          notificationBody: "There has been... ???",
          androidFullScreenIntent: true,
          enableNotificationOnKill: true,
          vibrate: true,
          volume: volume,
        ),
      ),
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Stack(
        children: [
          const _BackdropGradient(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: BeveledCard(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _DaysSelector(),
                  _SetTime(
                    dateTime: dateTime,
                    onTap: _setTime,
                  ),
                  _SetVolume(
                    onChanged: (value) {
                      volume = value;
                    },
                  ),
                  const Spacer(),
                  AnimatedOpacity(
                    duration: Durations.medium1,
                    opacity: canSet ? 1 : .2,
                    child: _SetBtn(
                      onTap: canSet ? _setAlarm : null,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
