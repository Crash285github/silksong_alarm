import 'package:permission_handler/permission_handler.dart';

/// Checks whether the Application has permission for scheduling
/// exact alarms
Future<PermissionStatus> checkAndroidScheduleExactAlarmPermission() async {
  PermissionStatus status = await Permission.scheduleExactAlarm.status;
  if (status.isDenied) {
    status = await Permission.scheduleExactAlarm.request();
  }

  return status;
}

/// Checks whether the Applicaiton has permission to send Notifications
Future<PermissionStatus> checkAndroidNotificationPermission() async {
  PermissionStatus status = await Permission.notification.status;
  if (status.isDenied) {
    status = await Permission.notification.request();
  }

  return status;
}
