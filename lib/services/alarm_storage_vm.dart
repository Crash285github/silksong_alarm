import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/alarm.dart';
import 'package:silksong_alarm/model/alarm_storage.dart';

class AlarmStorageVM extends ChangeNotifier {
  List<Alarm> get alarms => AlarmStorage.alarms;

  Future<bool> add(final Alarm alarm) async {
    final added = await AlarmStorage.add(alarm);
    notifyListeners();
    return added;
  }

  Future<bool> remove(final Alarm alarm) async {
    final removed = await AlarmStorage.remove(alarm);
    notifyListeners();
    return removed;
  }

  //_ Singleton
  static final _viewModel = AlarmStorageVM._internal();
  factory AlarmStorageVM() => _viewModel;
  AlarmStorageVM._internal();
}
