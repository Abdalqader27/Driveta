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
    required this.idImage,
    required this.personalImage,
    required this.certificateImage,
  }) : super(key: key);

  final ValueWidgetBuilder builder;
  final ValueChanged<XFile?> idImage;
  final ValueChanged<XFile?> personalImage;
  final ValueChanged<XFile?> certificateImage;

  @override
  State<SelectedImage> createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> imagesUri = [];
  XFile? idImage;
  XFile? personalImage;
  XFile? certificateImage;

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
                ' قم بإضافة هذه المستندات    \n-صورة الهوية الشخصية \n-صورة الوجه \n-رخصة القيادة ',
                style: textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: kGrey4,
                  fontSize: 16,
                ),
              )),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SSizedBox.v8(),
                    ImageSelectedItem(
                      selectedImage: idImage,
                      index: 0,
                      removeImageTap: () {
                        idImage = null;
                        widget.idImage(idImage);

                        setState(() {});
                      },
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () async {
                        idImage = await _picker.pickImage(
                            source: ImageSource.gallery);
                        widget.idImage(idImage);
                        setState(() {});
                      },
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: kGrey2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Icon(Icons.add, color: kGrey),
                            SPadding.all8(
                              child: MaterialText.caption(
                                'صورة الهوية  ',
                                style:
                                    textTheme.caption!.copyWith(color: kGrey4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SSizedBox.v8(),
                    ImageSelectedItem(
                      selectedImage: personalImage,
                      index: 0,
                      removeImageTap: () {
                        personalImage = null;
                        widget.personalImage(personalImage);

                        setState(() {});
                      },
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () async {
                        personalImage = await _picker.pickImage(
                            source: ImageSource.gallery);
                        widget.personalImage(personalImage);

                        setState(() {});
                      },
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: kGrey2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Icon(Icons.add, color: kGrey),
                            SPadding.all8(
                              child: MaterialText.caption(
                                'صورة الوجه',
                                style:
                                    textTheme.caption!.copyWith(color: kGrey4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SSizedBox.v8(),
                    ImageSelectedItem(
                      selectedImage: certificateImage,
                      index: 0,
                      removeImageTap: () {
                        certificateImage = null;
                        widget.certificateImage(certificateImage);

                        setState(() {});
                      },
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () async {
                        certificateImage = await _picker.pickImage(
                            source: ImageSource.gallery);
                        widget.certificateImage(certificateImage);

                        setState(() {});
                      },
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: kGrey2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Icon(Icons.add, color: kGrey),
                            SPadding.all8(
                              child: MaterialText.caption(
                                'رخصة القيادة ',
                                style:
                                    textTheme.caption!.copyWith(color: kGrey4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<XFile?> _pickedImage(XFile? xfile) async {
    XFile? file;
    showDialog(
        context: context,
        builder: (context) => SelectImageDialog(
              onEvent: (ImageSource? source) async {
                if (source != null) {
                  file = await selectImage(source);
                }
              },
            ));
    return file;
  }

  Future<XFile?> selectImage(ImageSource imageSource) async {
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
              return selectedImages.first;
            }
          }
        } else {
          BotToast.showText(text: 'لايوجد صلاحيات للمستندات');

          return null;
        }
      } else {
        if (await Permission.camera.request().isGranted) {
          final XFile? image = await _picker.pickImage(
              source: imageSource,
              maxWidth: 1200,
              maxHeight: 1200,
              imageQuality: 80);
          if (image != null) {
            return image;
          }
        } else {
          BotToast.showText(text: 'لايوجد صلاحيات للكاميرة');
          return null;
        }
      }
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: e.toString());
    }
  }
}
