part of '../home_page.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  Future<void> _autoStart() async => await getAutoStartPermission();

  Future<void> _checkAlarmPerms(BuildContext context) async {
    final res = await checkAndroidScheduleExactAlarmPermission();

    if (context.mounted) {
      await showPopupWidget(context, text: "Permission\n${res.name}");
    }
  }

  Future<void> _checkNotificationPerms(BuildContext context) async {
    final res = await checkAndroidNotificationPermission();

    if (context.mounted) {
      await showPopupWidget(context, text: "Permission\n${res.name}");
    }
  }

  Future<void> _downloadLatestNews(BuildContext context) async {
    final res = await SilksongNews.download();

    if (context.mounted) {
      await showPopupWidget(context, text: res.text);
    }
  }

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
                        onTap: _autoStart,
                      ),
                      SettingTemplate(
                        onTap: () => _checkAlarmPerms(context),
                        text: "Check alarm perms",
                        icon: Icons.alarm,
                      ),
                      SettingTemplate(
                        onTap: () => _checkNotificationPerms(context),
                        text: "Check notification perms",
                        icon: Icons.notifications,
                      ),
                      SettingTemplate(
                        onTap: () => _downloadLatestNews(context),
                        text: "Download latest news",
                        icon: Icons.download_done_outlined,
                      ),
                      const Spacer(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "v${Persistence.appVersion}",
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
