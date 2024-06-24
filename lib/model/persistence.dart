import 'package:shared_preferences/shared_preferences.dart';

class Persistence {
  static final _prefs = SharedPreferences.getInstance();

  static Future<bool> setLatestVideoId(String id) async =>
      await (await _prefs).setString("latestVideoId", id);

  static Future<String?> getLatestVideoId() async =>
      (await _prefs).getString('latestVideoId');
}
