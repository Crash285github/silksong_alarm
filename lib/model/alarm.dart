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
        assert(settings.volume != null),
        assert(
          days.every((final day) => day <= 6 && day >= 0),
        );

  /// The days `this` [Alarm] was set to ring on
  Set<int> get days => Set.unmodifiable(_days);

  /// Whether `this` [Alarm] ring (or rang) today or not
  bool get ringsToday => days.contains(DateTime.now().day);

  /// The unique id of `this` [Alarm]
  int get id => _settings.id;

  /// The next time `this` [Alarm] will ring
  DateTime get dateTime => _settings.dateTime;

  /// The time of day `this` [Alarm] will ring at
  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(dateTime);

  /// The volume of `this` [Alarm]
  double get volume => _settings.volume!;

  /// The [AlarmSettings] of `this` [Alarm]
  AlarmSettings get settings => _settings;

  /// Whether `this` [Alarm] will repeat based on the [days] given
  ///
  /// If [days] is empty, it means the [Alarm] will ring only once
  bool get repeating => _days.isNotEmpty;

  /// Whether `this` [Alarm] will vibrate while ringing
  bool get vibrating => _settings.vibrate;

  /// Whether `this` [Alarm] will loop the audio after it finishes
  bool get looping => _settings.loopAudio;

  /// Returns the next [DateTime] of ringing from the
  /// given [days] and [dateTime]
  static DateTime getNextDateTime(
    final List<int> days,
    final DateTime dateTime,
  ) {
    final now = DateTime.now().copyWith(
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    if (dateTime.isAfter(now.add(const Duration(minutes: 1)))) {
      return dateTime;
    }

    if (days.isEmpty) {
      return dateTime.add(const Duration(days: 1));
    }

    final today = now.weekday - 1;

    for (var i = 1; i <= 7; i++) {
      final day = (today + i) % 7;

      if (days.contains(day)) {
        final next = dateTime.add(Duration(days: i));

        if (next.isAfter(now.add(const Duration(minutes: 1)))) {
          return next;
        }

        return next.add(const Duration(days: 7));
      }
    }

    throw Exception("Couldn't find next date");
  }

  /// Returns the next time `this` [Alarm] will ring
  DateTime get nextDateTime => getNextDateTime(
        _days.toList(),
        dateTime,
      );

  // MARK: JSON
  /// Converts `this` [Alarm] into a `Map` object
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_days': _days.toList(),
      '_settings': _settings.toJson(),
    };
  }

  /// Converts a valid `Map` object into an [Alarm] object
  factory Alarm.fromMap(Map<String, dynamic> map) {
    return Alarm(
      days: Set<int>.from(map['_days'] as List),
      settings:
          AlarmSettings.fromJson(map['_settings'] as Map<String, dynamic>),
    );
  }

  /// Converts `this` [Alarm] into a `json` [String]
  String toJson() => json.encode(toMap());

  /// Converts a valid `json` [String] into an [Alarm]
  factory Alarm.fromJson(String source) =>
      Alarm.fromMap(json.decode(source) as Map<String, dynamic>);

  // MARK: EQ
  @override
  bool operator ==(covariant Alarm other) {
    if (identical(this, other)) return true;

    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
