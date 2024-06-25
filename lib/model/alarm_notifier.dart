import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/persistence.dart';

class AlarmNotifier extends ChangeNotifier {
  void notify() {
    Persistence.getAlarms();
    notifyListeners();
  }

  static final _notifier = AlarmNotifier._internal();
  factory AlarmNotifier() => _notifier;
  AlarmNotifier._internal();
}
