import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:driver/features/presentation/pages/sgin_up/widgets/select_image_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../widgets/src/material_text.dart';
import 'image_selected_item.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final ValueWidgetBuilder builder;

  @override
  State<SelectedImage> createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> imagesUri = [];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder(
      valueListenable: ValueNotifier(imagesUri),
      builder: widget.builder,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SPadding(
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 8.0,
                left: 8.0,
              ),
              child: MaterialText.headLine6(
                ' قم بإضافة هذه المستندات على (الترتيب) \n-صورة الهوية الشخصية \n-صورة الوجه \n-رخصة القيادة ',
                style: textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: kGrey4,
                  fontSize: 16,
                ),
              )),
          Visibility(
            visible: imagesUri.isNotEmpty,
            replacement: const SizedBox.shrink(),
            child: Column(
              children: [
                const SSizedBox.v8(),
                SizedBox(
                  height: 80,
                  width: context.widthPx,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: imagesUri.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ImageSelectedItem(
                        selectedImages: imagesUri,
                        index: index,
                        removeImageTap: () {
                          setState(() => imagesUri.removeAt(index));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: _pickedImage,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: kGrey2),
                  borderRadius: BorderRadius.circular(10)),
              child: SPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.add),
                        const SSizedBox.h4(),
                        SPadding.all8(
                          child: MaterialText.button(
                            'إضافة ',
                            style:
                                textTheme.titleMedium!.copyWith(color: kGrey4),
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pickedImage() async {
    showDialog(
        context: context,
        builder: (context) => SelectImageDialog(
              onEvent: (ImageSource? source) {
                if (source != null) {
                  _selectImage(source);
                }
              },
            ));
  }

  void _selectImage(ImageSource imageSource) async {
    Navigator.pop(context);
    try {
      if (imageSource == ImageSource.gallery) {
        if (await Permission.photos.request().isGranted) {
          final List<XFile>? selectedImages = await _picker.pickMultiImage(
            imageQuality: 80,
            maxHeight: 1200,
            maxWidth: 1200,
          );
          if (selectedImages != null) {
            if (selectedImages.isNotEmpty) {
              BotToast.showLoading();
              for (int i = 0; i < selectedImages.length; ++i) {
                imagesUri.add(selectedImages[i]);
              }
              BotToast.closeAllLoading();
            }
          }
        } else {
          BotToast.showText(text: 'لايوجد صلاحيات للمستندات');
        }
      } else {
        if (await Permission.camera.request().isGranted) {
          final XFile? image = await _picker.pickImage(
              source: imageSource,
              maxWidth: 1200,
              maxHeight: 1200,
              imageQuality: 80);
          if (image != null) {
            BotToast.showLoading();
            imagesUri.add(image);
          }
          BotToast.closeAllLoading();
        } else {
          BotToast.showText(text: 'لايوجد صلاحيات للكاميرة');
        }
      }
      setState(() {});
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: e.toString());
    }
  }
}
