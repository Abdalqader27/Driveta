import 'dart:io';

import 'package:design/design.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class InvoiceImageView extends StatelessWidget {
  final XFile? image;

  const InvoiceImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null) return Container();
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Stack(
          children: [
            PhotoView(
                maxScale: 3.0,
                minScale: PhotoViewComputedScale.contained,
                loadingBuilder: (_, __) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(kWhite),
                  ));
                },
                imageProvider: FileImage(File(image!.path))),
          ],
        ));
  }
}
