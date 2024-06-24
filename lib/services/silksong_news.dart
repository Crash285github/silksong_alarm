import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:path_provider/path_provider.dart';
import 'package:silksong_alarm/model/persistence.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SilksongNews {
  static final _yt = YoutubeExplode();

  static Future<void> init() async {
    await download();

    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 120,
        enableHeadless: true,
        forceAlarmManager: true,
        requiredNetworkType: NetworkType.ANY,
        requiresBatteryNotLow: false,
        startOnBoot: true,
        stopOnTerminate: false,
      ),
      () {},
      (String taskId) async => await BackgroundFetch.finish(taskId),
    );

    await BackgroundFetch.registerHeadlessTask(_headless);

    await BackgroundFetch.stop();

    await BackgroundFetch.start();
  }

  @pragma('vm:entry-point')
  static _headless(HeadlessTask task) async {
    if (task.timeout) {
      await BackgroundFetch.finish(task.taskId);
      return;
    }

    await download();

    await BackgroundFetch.finish(task.taskId);
  }

  static Future<String> get path async =>
      "${(await getApplicationCacheDirectory()).path}/alarm.mp3 ";

  @pragma('vm:entry-point')
  static Future<bool> download() async {
    try {
      final latest =
          await _yt.channels.getUploads("UC9OmOMZS6rU0_jIdZOxSHxw").first;

      if (latest.id.value == (await Persistence.getLatestVideoId())) {
        print("Already downloaded id: ${latest.id.value}");
        return true;
      }

      await Persistence.setLatestVideoId(latest.id.value);

      final streamManifest =
          await _yt.videos.streamsClient.getManifest(latest.id);

      final audioStreamInfo = streamManifest.audioOnly.withHighestBitrate();

      final audioStream = _yt.videos.streamsClient.get(audioStreamInfo);

      final audioFileStream = File(await path).openWrite();

      await audioStream.pipe(audioFileStream);
      await audioFileStream.flush();
      await audioFileStream.close();

      print("Downloaded id: ${latest.id.value}");
    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }
}
