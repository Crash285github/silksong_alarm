library set_alarm_sheet;

import 'dart:ui';

import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:volume_controller/volume_controller.dart';

import 'package:silksong_alarm/model/alarm.dart';
import 'package:silksong_alarm/model/days_enum.dart';
import 'package:silksong_alarm/model/news_background_worker/silksong_news.dart';
import 'package:silksong_alarm/model/persistence.dart';
import 'package:silksong_alarm/view/widget/beveled_card.dart';
import 'package:silksong_alarm/viewmodel/alarm_storage_vm.dart';

part 'backdrop_gradient.dart';
part 'days_selector.dart';
part 'set_btn.dart';
part 'set_loop.dart';
part 'set_time.dart';
part 'set_vibration.dart';
part 'set_volume.dart';

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
  final Set<int> days = {};
  DateTime dateTime = DateTime.now().copyWith(second: 0);
  double volume = .5;
  bool loop = false;
  bool vibrate = true;

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

      if (time.isBefore(
        DateTime.now().subtract(
          const Duration(minutes: 1),
        ),
      )) {
        time = time.add(const Duration(days: 1));
      }

      setState(() => dateTime = time);
    }
  }

  Future<void> _setAlarm() async {
    final newsData = await Persistence.getSilksongNewsData();

    final nextDate = Alarm.getNextDateTime(days.toList(), dateTime);

    await AlarmStorageVM().add(
      Alarm(
        days: days,
        settings: AlarmSettings(
          id: DateTime.now().millisecondsSinceEpoch % 100000,
          dateTime: nextDate,
          assetAudioPath: await SilksongNews.path,
          notificationTitle: newsData?.title ?? "Your Daily Silksong Alarm",
          notificationBody: newsData?.description ?? "There has been... ???",
          androidFullScreenIntent: true,
          enableNotificationOnKill: true,
          loopAudio: loop,
          fadeDuration: 0,
          vibrate: vibrate,
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
                  _DaysSelector(days),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SetVibration(
                          vibrate: vibrate,
                          onTap: () => setState(() => vibrate = !vibrate),
                        ),
                        _SetTime(
                          dateTime: dateTime,
                          onTap: _setTime,
                        ),
                        _SetLoop(
                          loop: loop,
                          onTap: () => setState(() => loop = !loop),
                        ),
                      ],
                    ),
                  ),
                  _SetVolume(
                    onChanged: (value) {
                      volume = value;
                    },
                  ),
                  const Spacer(),
                  _SetBtn(onTap: _setAlarm)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
