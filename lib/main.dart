import 'package:alarm/alarm.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Hello World!'),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Text(
                "Settings",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ListTile(
                leading: const Icon(Icons.run_circle_outlined),
                title: const Text("Auto Start"),
                onTap: () async => await getAutoStartPermission(),
              ),
              ListTile(
                leading: const Icon(Icons.rule),
                title: const Text("Check Alarm Permission"),
                onTap: () async {
                  final res = await checkAndroidScheduleExactAlarmPermission();

                  if (context.mounted) {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                          "Permission is ${res.name}",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        actions: [
                          TextButton(
                            child: const Text("ok"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<PermissionStatus> checkAndroidScheduleExactAlarmPermission() async {
  final status = await Permission.scheduleExactAlarm.status;
  if (status.isDenied) {
    final res = await Permission.scheduleExactAlarm.request();

    return res;
  }

  return status;
}
