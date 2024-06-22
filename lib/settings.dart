import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';
import 'package:silksong_alarm/permissions.dart';
import 'package:silksong_alarm/silksong_news.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Text(
              "Settings",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const _AutoStart(),
            const _AlarmPermission(),
            const _NotificationPermission(),
            const _DownloadNews(),
          ],
        ),
      ),
    );
  }
}

class _DownloadNews extends StatelessWidget {
  const _DownloadNews();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.download),
      title: const Text("Download latest news"),
      onTap: () async {
        final res = await SilksongNews.download();

        if (context.mounted) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                "Downloaded: $res",
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
    );
  }
}

class _AutoStart extends StatelessWidget {
  const _AutoStart();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.run_circle_outlined),
      title: const Text("Auto Start"),
      onTap: () async => await getAutoStartPermission(),
    );
  }
}

class _AlarmPermission extends StatelessWidget {
  const _AlarmPermission();

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}

class _NotificationPermission extends StatelessWidget {
  const _NotificationPermission();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications),
      title: const Text("Check Notification Permission"),
      onTap: () async {
        final res = await checkAndroidNotificationPermission();

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
                  onPressed: () => Navigator.pop(context),
                  child: const Text("ok"),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
