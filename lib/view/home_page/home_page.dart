library home_page;

import 'dart:async';
import 'dart:ui';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';

import 'package:silksong_alarm/model/persistence.dart';
import 'package:silksong_alarm/services/permissions.dart';
import 'package:silksong_alarm/services/silksong_news.dart';
import 'package:silksong_alarm/view/home_page/alarm_list.dart';
import 'package:silksong_alarm/view/ring_page/ring_page.dart';
import 'package:silksong_alarm/view/set_alarm_sheet/set_alarm_sheet.dart';
import 'package:silksong_alarm/view/widget/beveled_card.dart';

part "drawer/backdrop_gradient.dart";
part "drawer/setting_template.dart";
part "drawer/settings_drawer.dart";
part "drawer/show_alarm_sheet_button.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static StreamSubscription<AlarmSettings>? _subscription;

  @override
  void initState() {
    super.initState();

    checkAndroidNotificationPermission();
    checkAndroidScheduleExactAlarmPermission();

    Persistence.getAlarms();

    _subscription ??= Alarm.ringStream.stream.listen(_navigateToRingScreen);
  }

  Future<void> _navigateToRingScreen(final AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => RingPage(alarmSettings: alarmSettings),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Silksong Alarm"),
          centerTitle: true,
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: const AlarmList(),
        drawer: const SettingsDrawer(),
        floatingActionButton: const ShowAlarmSheetButton(),
      );
}
