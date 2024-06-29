library home_page;

import 'dart:async';
import 'dart:ui';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:silksong_alarm/fading_scrollables/fading_scrollables.dart';

import 'package:silksong_alarm/model/persistence.dart';
import 'package:silksong_alarm/services/permissions.dart';
import 'package:silksong_alarm/services/silksong_news.dart';
import 'package:silksong_alarm/view/home_page/alarm_list.dart';
import 'package:silksong_alarm/view/ring_page/ring_page.dart';
import 'package:silksong_alarm/view/set_alarm_sheet/set_alarm_sheet.dart';
import 'package:silksong_alarm/view/widget/beveled_card.dart';
import 'package:silksong_alarm/view/widget/popup.dart.dart';

part "drawer/backdrop_gradient.dart";
part "drawer/setting_template.dart";
part "drawer/settings_drawer.dart";
part "show_alarm_sheet_button.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _scrollController = ScrollController();
  static StreamSubscription<AlarmSettings>? _subscription;

  static bool _showFab = true;

  @override
  void initState() {
    super.initState();

    checkAndroidNotificationPermission();
    checkAndroidScheduleExactAlarmPermission();

    Persistence.getAlarms();

    _scrollController.addListener(() {
      if (_scrollController.offset < 10 && !_showFab) {
        setState(() => _showFab = true);
      }

      if (_scrollController.offset > 20 && _showFab) {
        setState(() => _showFab = false);
      }
    });

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
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              title: const Text("Silksong Alarm"),
              centerTitle: true,
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            const AlarmList(),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
              ),
            )
          ],
        ).fade(gradientSize: 180),
        drawer: const SettingsDrawer(),
        floatingActionButton: _showFab ? const ShowAlarmSheetButton() : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
}
