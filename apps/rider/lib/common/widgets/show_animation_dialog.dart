import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';

import 'custom_offset_animation.dart';

void showAnimationDialog({
  required Widget dialog,
  VoidCallback? onClose,
}) {
  BotToast.showAnimationWidget(
      clickClose: false,
      allowClick: false,
      onlyOne: true,
      crossPage: true,
      onClose: onClose,
      wrapToastAnimation: (
        AnimationController controller,
        VoidCallback cancel,
        Widget child,
      ) {
        return Stack(
          children: <Widget>[
            GestureDetector(
              onTap: cancel,
              child: AnimatedBuilder(
                builder: (_, Widget? child) => Opacity(
                  opacity: controller.value,
                  child: child,
                ),
                animation: controller,
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: kBlack4),
                  child: SizedBox.expand(),
                ),
              ),
            ),
            CustomOffsetAnimation(
              controller: controller,
              child: child,
            )
          ],
        );
      },
      toastBuilder: (VoidCallback cancelFunc) {
        return dialog;
      },
      animationDuration: const Duration(milliseconds: 300));
}
