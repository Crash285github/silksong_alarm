import 'dart:convert';

import 'package:alarm/alarm.dart' as pckg;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silksong_alarm/model/alarm.dart';

enum _Keys {
  alarms("alarms"),
  ;

  final String key;

  const _Keys(this.key);
}

class Persistence {
  static final _prefs = SharedPreferences.getInstance();

  static Future<bool> saveAlarms(final Set<Alarm> alarms) async =>
      await (await _prefs).setString(
        _Keys.alarms.key,
        jsonEncode(alarms),
      );

  static Future<Set<Alarm>?> loadAlarms() async {
    pckg.Alarm.getAlarms();

    final json = (await _prefs).getString(_Keys.alarms.key);

    if (json == null) return null;

    return jsonDecode(json) as Set<Alarm>;
  }

  static Future<bool> setLatestVideoId(String id) async =>
      await (await _prefs).setString("latestVideoId", id);

  static Future<String?> getLatestVideoId() async =>
      (await _prefs).getString('latestVideoId');
}
