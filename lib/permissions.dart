import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> checkAndroidScheduleExactAlarmPermission() async {
  PermissionStatus status = await Permission.scheduleExactAlarm.status;
  if (status.isDenied) {
    status = await Permission.scheduleExactAlarm.request();
  }

  return status;
}

Future<PermissionStatus> checkAndroidNotificationPermission() async {
  PermissionStatus status = await Permission.notification.status;
  if (status.isDenied) {
    status = await Permission.notification.request();
  }

  return status;
}
