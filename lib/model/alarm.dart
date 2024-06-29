import 'dart:convert';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';

class Alarm {
  final Set<int> _days;
  final AlarmSettings _settings;

  Alarm({
    required Set<int> days,
    required AlarmSettings settings,
  })  : _days = days,
        _settings = settings,
        assert(
          days.every((final day) => day <= 7 && day >= 1),
        );

  Set<int> get days => Set.unmodifiable(_days);
  bool get ringsToday => days.contains(DateTime.now().day);

  int get id => _settings.id;

  DateTime get dateTime => _settings.dateTime;
  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(dateTime);

  double? get volume => _settings.volume;

  AlarmSettings get settings => _settings;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_days': _days.toList(),
      '_settings': _settings.toJson(),
    };
  }

  factory Alarm.fromMap(Map<String, dynamic> map) {
    return Alarm(
      days: Set<int>.from(map['_days'] as Set<int>),
      settings:
          AlarmSettings.fromJson(map['_settings'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Alarm.fromJson(String source) =>
      Alarm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Alarm other) {
    if (identical(this, other)) return true;

    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
