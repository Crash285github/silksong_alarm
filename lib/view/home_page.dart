import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/persistence.dart';
import 'package:silksong_alarm/view/alarm_list.dart';
import 'package:silksong_alarm/services/permissions.dart';
import 'package:silksong_alarm/view/ring_screen.dart';
import 'package:silksong_alarm/view/set_alarm_sheet/set_alarm_sheet.dart';

import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    super.initState();

    checkAndroidNotificationPermission();
    checkAndroidScheduleExactAlarmPermission();

    Persistence.getAlarms();

    subscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => RingScreen(alarmSettings: alarmSettings),
      ),
    );
    Persistence.getAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Silksong Alarm"),
      ),
      body: AlarmList(),
      drawer: const Settings(),
      floatingActionButton: const SetAlarmButton(),
    );
  }
}
