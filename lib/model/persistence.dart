import 'dart:convert';

import 'package:alarm/alarm.dart' as pckg;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silksong_alarm/model/alarm.dart';
import 'package:silksong_alarm/model/news_background_worker/silksong_news_data.dart';

enum _Keys {
  alarms,
  silksongNewsData,
}

class Persistence {
  static final _prefs = SharedPreferences.getInstance();

  static Future<bool> saveAlarms(final List<Alarm> alarms) async =>
      await (await _prefs).setString(
        _Keys.alarms.name,
        jsonEncode(alarms),
      );

  static Future<List<Alarm>?> loadAlarms() async {
    pckg.Alarm.getAlarms();

    final json = (await _prefs).getString(_Keys.alarms.name);

    if (json == null) return null;

    return (jsonDecode(json) as List)
        .map<Alarm>(
          (final alarm) => Alarm.fromJson(alarm),
        )
        .toList();
  }

  static Future<bool> setSilksongNewsData(final SilksongNewsData data) async =>
      await (await _prefs)
          .setString(_Keys.silksongNewsData.name, data.toJson());

  static Future<SilksongNewsData?> getSilksongNewsData() async {
    final json = (await _prefs).getString(_Keys.silksongNewsData.name);

    if (json == null) return null;

    return SilksongNewsData.fromJson(json);
  }
}
