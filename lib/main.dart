import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silksong_alarm/model/news_background_worker/silksong_news.dart';
import 'package:silksong_alarm/model/persistence.dart';

import 'view/home_page/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Persistence.init();

  SilksongNews.init();

  await Alarm.init();

  runApp(const SilksongAlarmApp());
}

class SilksongAlarmApp extends StatelessWidget {
  const SilksongAlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}
