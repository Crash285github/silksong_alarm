import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Persistence {
  static final _prefs = SharedPreferences.getInstance();

  static List<AlarmSettings> alarms = [];

  static void getAlarms() async => alarms = Alarm.getAlarms()
    ..sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);

  static Future<bool> setLatestVideoId(String id) async =>
      await (await _prefs).setString("latestVideoId", id);

  static Future<String?> getLatestVideoId() async =>
      (await _prefs).getString('latestVideoId');
}
