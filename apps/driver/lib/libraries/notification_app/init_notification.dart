import 'package:flutter/material.dart';

import 'service/notifications_firebase.dart';

enum DisplayType { dialog, pop }

class InitializerNotification extends StatefulWidget {
  final Widget child;

  final DisplayType displayType;

  /// Specifies if the notification should automatically dismissed
  final bool autoCancel;

  const InitializerNotification(
      {Key? key, required this.child, this.autoCancel = true, this.displayType = DisplayType.pop})
      : super(key: key);

  @override
  _InitializerNotificationState createState() => _InitializerNotificationState();
}

class _InitializerNotificationState extends State<InitializerNotification> {
  @override
  void initState() {
    FirebaseNotification(
      context: context,
      autoCancel: widget.autoCancel,
      displayType: widget.displayType,
    ).setUpFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
