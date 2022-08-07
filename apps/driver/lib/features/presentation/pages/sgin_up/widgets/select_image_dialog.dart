import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/src/material_text.dart';

class SelectImageDialog extends StatelessWidget {
  final ValueChanged<ImageSource?> onEvent;

  const SelectImageDialog({Key? key, required this.onEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SSizedBox(
        width: 350,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SPadding.all16(
                  child: MaterialText.title(
                'اختر الصورة',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              )),
              SPadding.trl16(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DialogItem(
                      text: 'التقاط',
                      icon: Icons.camera,
                      onTap: () {
                        BotToast.cleanAll();
                        onEvent(ImageSource.camera);
                      },
                    ),
                    _DialogItem(
                      text: 'المستندات',
                      icon: Icons.photo_camera_back,
                      onTap: () {
                        BotToast.cleanAll();
                        onEvent(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
              const SSizedBox.v16(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onTap;

  const _DialogItem(
      {Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SPadding.all8(
        child: InkWell(
            onTap: onTap,
            child: Center(
              child: SPadding.all16(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SPadding.all8(child: Icon(icon)),
                    MaterialText.subTitle2(text)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
