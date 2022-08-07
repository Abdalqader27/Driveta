import 'dart:io';

import 'package:design/design.dart';
import 'package:image_picker/image_picker.dart';

import 'image_slider.dart';

class ImageSelectedItem extends StatelessWidget {
  final List<XFile?> selectedImages;

  final Function() removeImageTap;
  final int index;

  const ImageSelectedItem({
    Key? key,
    required this.selectedImages,
    required this.index,
    required this.removeImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: 'عرض المستندات',
                      pageBuilder: (
                        BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) =>
                          ImageSliderView(
                            removeImageTap: removeImageTap,
                            images: selectedImages,
                            index: index,
                          ));
                },
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.file(
                    File(selectedImages[index]!.path),
                    fit: BoxFit.contain,
                  ),
                ),
              )),
          Positioned(
            right: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: removeImageTap,
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
