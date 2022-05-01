import 'package:flutter/material.dart';

import 'notification_dialog.dart';

Future<dynamic> notificationDialog(
    {required String title,
    required String subTitle,
    required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (context) => NotificationDialog(
            title: title,
            subTitle: subTitle,
            onConfirm: () => Navigator.of(context).pop(),
            textButtonConfirm: "حسناً",
          ));
}
