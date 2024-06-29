library silksong_news;

import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:path_provider/path_provider.dart';
import 'package:silksong_alarm/model/news_background_worker/silksong_news_data.dart';
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
  static Future<DownloadResponse> download() async {
    try {
      final latest =
          await _yt.channels.getUploads("UC9OmOMZS6rU0_jIdZOxSHxw").first;

      final silksongData = await Persistence.getSilksongNewsData();

      if (silksongData?.id == latest.id.value) {
        return DownloadResponse.alreadyHave;
      }

      await Persistence.setSilksongNewsData(
        SilksongNewsData(
          id: latest.id.value,
          title: latest.title,
          description: latest.description,
          seconds: latest.duration?.inSeconds ?? 0,
        ),
      );

      final streamManifest =
          await _yt.videos.streamsClient.getManifest(latest.id);

      final audioStreamInfo = streamManifest.audioOnly.withHighestBitrate();

      final audioStream = _yt.videos.streamsClient.get(audioStreamInfo);

      final audioFileStream = File(await path).openWrite();

      await audioStream.pipe(audioFileStream);
      await audioFileStream.flush();
      await audioFileStream.close();
    } catch (e) {
      return DownloadResponse.failed;
    }

    return DownloadResponse.downloaded;
  }
}

enum DownloadResponse {
  failed("Failed"),
  downloaded("Downloaded"),
  alreadyHave("Already downloaded"),
  ;

  final String text;
  const DownloadResponse(this.text);
}
