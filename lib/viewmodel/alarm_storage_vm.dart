import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/alarm.dart';
import 'package:silksong_alarm/model/alarm_storage.dart';

class AlarmStorageVM extends ChangeNotifier {
  List<Alarm> get alarms => AlarmStorage.alarms;

  /// Adds a new [Alarm] to the [AlarmStorage]
  Future<bool> add(final Alarm alarm) async {
    final added = await AlarmStorage.add(alarm);

    notifyListeners();
    return added;
  }

  /// Completely removes an [Alarm] from the [AlarmStorage]
  Future<bool> remove(final Alarm alarm) async {
    final removed = await AlarmStorage.remove(alarm);

    notifyListeners();
    return removed;
  }

  /// Replaces [AlarmStorage.alarms] with the given list
  void replace(final List<Alarm> alarms) {
    AlarmStorage.replace(alarms);
    notifyListeners();
  }

  /// Stops the given alarms and reschedules it to next time
  Future<bool> stop(final Alarm alarm) async {
    final removed = await AlarmStorage.remove(alarm);

    bool added = true;
    if (alarm.repeating) {
      added = await AlarmStorage.add(
        Alarm(
          days: alarm.days,
          settings: alarm.settings.copyWith(
            dateTime: alarm.nextDateTime,
          ),
        ),
      );
    }

    notifyListeners();
    return removed && added;
  }

  //_ Singleton
  static final _viewModel = AlarmStorageVM._internal();
  factory AlarmStorageVM() => _viewModel;
  AlarmStorageVM._internal();
}
