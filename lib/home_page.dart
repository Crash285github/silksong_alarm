import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:silksong_alarm/alarm_list.dart';
import 'package:silksong_alarm/permissions.dart';
import 'package:silksong_alarm/ring_screen.dart';
import 'package:silksong_alarm/set_alarm.dart';

import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<AlarmSettings> alarms;
  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    super.initState();

    checkAndroidNotificationPermission();
    checkAndroidScheduleExactAlarmPermission();

    loadAlarms();

    subscription ??= Alarm.ringStream.stream.listen(navigateToRingScreen);
  }

  void loadAlarms() => setState(() {
        alarms = Alarm.getAlarms();
        alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
      });

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => RingScreen(alarmSettings: alarmSettings),
      ),
    );
    loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Silksong Alarm"),
      ),
      body: AlarmList(alarms: alarms),
      drawer: const Settings(),
      floatingActionButton: const SetAlarmButton(),
    );
  }
}
