import 'package:bot_toast/bot_toast.dart';

import 'package:design/design.dart';

void showSnack({required BuildContext context, required String text, Color? color}) {
  //popup a attachments toast
  BotToast.showCustomText(
      duration: const Duration(seconds: 4),
      toastBuilder: (void Function() cancelFunc) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color ?? kRed0,
          ),
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: const TextStyle(color: kWhite, fontSize: 15),
          ),
        );
      });
}
