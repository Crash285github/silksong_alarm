import 'package:silksong_alarm/model/alarm.dart';
import 'package:alarm/alarm.dart' as pckg;
import 'package:silksong_alarm/model/persistence.dart';

class AlarmStorage {
  static final List<Alarm> _alarms = [];
  static List<Alarm> get alarms => List.unmodifiable(_alarms);

  static void replace(final List<Alarm> alarms) => _alarms
    ..clear()
    ..addAll(alarms);

  static Future<bool> add(final Alarm alarm) async {
    final res = await pckg.Alarm.set(alarmSettings: alarm.settings);

    if (res) {
      _alarms.add(alarm);

      Persistence.saveAlarms(_alarms);
    }

    return res;
  }

  static Future<bool> remove(final Alarm alarm) async {
    final res = await pckg.Alarm.stop(alarm.id);

    if (res) {
      _alarms.remove(alarm);

      Persistence.saveAlarms(alarms);
    }

    return res;
  }
}
