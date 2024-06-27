import 'dart:ui';

import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';
import 'package:silksong_alarm/services/permissions.dart';
import 'package:silksong_alarm/services/silksong_news.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(.2),
                Colors.red.withOpacity(0),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
          ),
          SafeArea(
            child: Card(
              margin: const EdgeInsets.all(24),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Settings",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SettingTemplate(
                    text: "Auto Start",
                    icon: Icons.run_circle_outlined,
                    onTap: () async => await getAutoStartPermission(),
                  ),
                  _SettingTemplate(
                    onTap: () async {
                      final res =
                          await checkAndroidScheduleExactAlarmPermission();

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
                    text: "Check alarm permission",
                    icon: Icons.alarm,
                  ),
                  _SettingTemplate(
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
                    text: "Check notification permission",
                    icon: Icons.notifications,
                  ),
                  _SettingTemplate(
                    onTap: () async {
                      final res = await SilksongNews.download();

                      if (context.mounted) {
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
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
                    text: "Download latest news",
                    icon: Icons.download_done_outlined,
                  ),
                  const Spacer(),
                  const Center(
                    child: Text("v0.1.0"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingTemplate extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData icon;
  const _SettingTemplate({
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        type: MaterialType.transparency,
        shape: BeveledRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.elliptical(16, 32)),
          side: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 24.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
