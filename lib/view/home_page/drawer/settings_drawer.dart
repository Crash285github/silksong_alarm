part of '../home_page.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Stack(
          children: [
            const BackdropGradient(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: BeveledCard(
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Settings",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SettingTemplate(
                        text: "Auto Start",
                        icon: Icons.run_circle_outlined,
                        onTap: () async => await getAutoStartPermission(),
                      ),
                      SettingTemplate(
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
                        text: "Check alarm perms",
                        icon: Icons.alarm,
                      ),
                      SettingTemplate(
                        onTap: () async {
                          final res =
                              await checkAndroidNotificationPermission();

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
                        text: "Check notification perms",
                        icon: Icons.notifications,
                      ),
                      SettingTemplate(
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "v0.1.0",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(.3),
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
