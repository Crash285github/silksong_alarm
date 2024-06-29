import 'package:silksong_alarm/model/alarm.dart';
import 'package:alarm/alarm.dart' as pckg;

class AlarmStorage {
  static final List<Alarm> _alarms = [];
  static List<Alarm> get alarms => List.unmodifiable(_alarms);

  static Future<bool> add(final Alarm alarm) async {
    final res = await pckg.Alarm.set(alarmSettings: alarm.settings);

    if (res) {
      _alarms.add(alarm);
    }

    return res;
  }

  static Future<bool> remove(final Alarm alarm) async {
    final res = await pckg.Alarm.stop(alarm.id);

    if (res) {
      _alarms.remove(alarm);
    }

    return res;
  }
}
