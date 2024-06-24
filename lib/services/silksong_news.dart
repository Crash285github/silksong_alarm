import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SilksongNews {
  static final _yt = YoutubeExplode();

  static Future<String> get path async =>
      "${(await getApplicationCacheDirectory()).path}/alarm.mp3 ";

  @pragma('vm:entry-point')
  static Future<bool> download() async {
    try {
      final latest =
          await _yt.channels.getUploads("UC9OmOMZS6rU0_jIdZOxSHxw").first;

      final streamManifest =
          await _yt.videos.streamsClient.getManifest(latest.id);

      final audioStreamInfo = streamManifest.audioOnly.withHighestBitrate();

      final audioStream = _yt.videos.streamsClient.get(audioStreamInfo);

      final audioFileStream = File(await path).openWrite();

      await audioStream.pipe(audioFileStream);
      await audioFileStream.flush();
      await audioFileStream.close();
    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }
}
