import 'package:silksong_alarm/model/alarm.dart';
import 'package:alarm/alarm.dart' as pckg;
import 'package:silksong_alarm/model/persistence.dart';

class AlarmStorage {
  static final List<Alarm> _alarms = [];

  /// An unmodifiable `List` of [Alarm]s
  static List<Alarm> get alarms => List.unmodifiable(_alarms);

  /// Replaces [AlarmStorage.alarms] with the given `List`
  static void replace(final List<Alarm> alarms) => _alarms
    ..clear()
    ..addAll(alarms);

  /// Adds an [Alarm] to the Storage
  ///
  /// This also schedules the [Alarm]
  static Future<bool> add(final Alarm alarm) async {
    final res = await pckg.Alarm.set(alarmSettings: alarm.settings);

    if (res) {
      _alarms.add(alarm);

      Persistence.saveAlarms(_alarms);
    }

    return res;
  }

  /// Removes and [Alarm] from the Storage
  ///
  /// This also cancles the [Alarm]
  static Future<bool> remove(final Alarm alarm) async {
    final res = await pckg.Alarm.stop(alarm.id);

    if (res) {
      _alarms.remove(alarm);

      Persistence.saveAlarms(alarms);
    }

    return res;
  }
}
