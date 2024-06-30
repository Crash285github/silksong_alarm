import 'dart:convert';

import 'package:alarm/alarm.dart' as pckg;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silksong_alarm/model/alarm.dart';
import 'package:silksong_alarm/model/news_background_worker/silksong_news_data.dart';

/// Stores keys for [SharedPreferences]
///
/// Use them as `_Keys.(key).name`
enum _Keys {
  alarms,
  silksongNewsData,
}

class Persistence {
  static final _prefs = SharedPreferences.getInstance();

  /// The current version of the application
  static late final String appVersion;

  /// Initializes the [Persistence] layer:
  /// - assigns a value to [Persistence.appVersion]
  static Future<void> init() async {
    final info = await PackageInfo.fromPlatform();
    appVersion = info.version;
  }

  /// Saves the given [Alarm]s to [Persistence]
  static Future<bool> saveAlarms(final List<Alarm> alarms) async =>
      await (await _prefs).setString(
        _Keys.alarms.name,
        jsonEncode(alarms),
      );

  /// Loads and `returns` a `List` of [Alarm]s from [Persistence],
  /// or `null` if it was never saved
  static Future<List<Alarm>?> loadAlarms() async {
    pckg.Alarm.getAlarms();

    final json = (await _prefs).getString(_Keys.alarms.name);

    if (json == null) return null;

    return (jsonDecode(json) as List)
        .map<Alarm>(
          (final alarm) => Alarm.fromJson(alarm),
        )
        .toList();
  }

  /// Saves the given [SilksongNewsData] to [Persistence]
  static Future<bool> setSilksongNewsData(final SilksongNewsData data) async =>
      await (await _prefs)
          .setString(_Keys.silksongNewsData.name, data.toJson());

  /// Loads and `returns` a [SilksongNewsData] from [Persistence],
  /// or `null` if it was never saved
  static Future<SilksongNewsData?> getSilksongNewsData() async {
    final json = (await _prefs).getString(_Keys.silksongNewsData.name);

    if (json == null) return null;

    return SilksongNewsData.fromJson(json);
  }
}
