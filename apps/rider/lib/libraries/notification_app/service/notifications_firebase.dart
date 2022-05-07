import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../init_notification.dart';
import '../util/strings.dart';
import '../widgets/notification_dialog_function.dart';
import 'local_notification_service.dart';

class FirebaseNotification {
  final BuildContext context;

  final bool autoCancel;

  final DisplayType displayType;

  final LocalNotificationService _localNotificationService = LocalNotificationService();

  FirebaseNotification({required this.context, required this.autoCancel, required this.displayType});

  Future<void> setUpFirebase() async {
    _localNotificationService.initialize();
    // await Firebase.initializeApp();
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    await FirebaseMessaging.instance.getToken().then((value) {
      firebaseToken = value ?? "";
      log("firebaseToken:      $value");
      // Logs.logger.i("user id:      ${getIt<AuthUseCase>().getUser()?.id}");
    });
    FirebaseMessaging.onMessage.listen((event) => onMessage(event));
  }

  Future<dynamic> onMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      final body = notification.body;
      final title = notification.title;
      if (body != null && title != null) {
        switch (displayType) {
          case DisplayType.dialog:
            {
              notificationDialog(title: title, subTitle: body, context: context);
            }
            break;
          case DisplayType.pop:
            {
              _localNotificationService.display(message, autoCancel);
            }
            break;
        }
      }
    }
  }
}
