import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  late final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  void initialize() {
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    const MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? route) async {
        if (route != null) {}
      },
    );
  }

  Future<void> display(RemoteMessage message, bool autoCancel) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails("test", "test channel",
            channelDescription: "this is our channel",
            importance: Importance.max,
            priority: Priority.high,
            autoCancel: autoCancel),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      // Logs.logger.i(e);
    }
  }
}
