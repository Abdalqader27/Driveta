import 'dart:io';

import 'package:design/design.dart';
import 'package:image_picker/image_picker.dart';

import 'image_slider.dart';

class ImageSelectedItem extends StatelessWidget {
  final Function() removeImageTap;
  final int index;
  final XFile? selectedImage;
  const ImageSelectedItem({
    Key? key,
    required this.index,
    required this.selectedImage,
    required this.removeImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedImage == null) return Container();
    return SizedBox(
      height: 100,
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
                    images: selectedImage,
                    index: index,
                  ));
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: FileImage(
                      File(selectedImage!.path),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 10,
                    color: kWhite,
                    onPressed: removeImageTap,
                    icon: Icon(
                      Icons.close,
                      size: 15,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
