library silksong_news;

import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:path_provider/path_provider.dart';
import 'package:silksong_alarm/model/news_background_worker/silksong_news_data.dart';
import 'package:silksong_alarm/model/persistence.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SilksongNews {
  static final _yt = YoutubeExplode();

  static late final String _appCacheDir;

  /// Initializes the [SilksongNews] fetcher:
  /// - downloads the latest news (doesnt download if already downloaded)
  /// - finds the application cache directory
  /// - Configures the background worker to run every 2 hours and check for
  /// Silksong news
  static Future<void> init() async {
    download();

    _appCacheDir = (await getApplicationCacheDirectory()).path;

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

  /// The path the Silksong news was saved into
  static String get path => "$_appCacheDir/alarm.mp3 ";

  /// The background worker method that downloads the latest news
  ///
  /// Annotation required for background worker methods
  @pragma('vm:entry-point')
  static _headless(HeadlessTask task) async {
    if (task.timeout) {
      await BackgroundFetch.finish(task.taskId);
      return;
    }

    await download();

    await BackgroundFetch.finish(task.taskId);
  }

  /// Downloads the latest news, unless it has already been downloaded
  ///
  /// Return an enum:
  /// - [DownloadResponse.downloaded] : a new Daily News has been downloaded
  /// - [DownloadResponse.alreadyHave] : the newsed Daily News has already
  /// been downloaded and wont be downloaded again
  /// - [DownloadResponse.failed] : the download failed
  ///
  /// Annotation required for background worker methods
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

      final audioFileStream = File(path).openWrite();

      await audioStream.pipe(audioFileStream);
      await audioFileStream.flush();
      await audioFileStream.close();
    } catch (e) {
      return DownloadResponse.failed;
    }

    return DownloadResponse.downloaded;
  }
}

/// An enum for the return values of [SilksongNews.download]
enum DownloadResponse {
  failed("Failed"),
  downloaded("Downloaded"),
  alreadyHave("Already downloaded"),
  ;

  final String text;
  const DownloadResponse(this.text);
}
