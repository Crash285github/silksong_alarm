import 'package:flutter/material.dart';

class AlarmNotifier extends ChangeNotifier {
  void notify() => notifyListeners();

  static final _notifier = AlarmNotifier._internal();

  factory AlarmNotifier() => _notifier;

  AlarmNotifier._internal();
}
