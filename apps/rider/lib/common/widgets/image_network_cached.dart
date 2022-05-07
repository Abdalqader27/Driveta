import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import 'image_view.dart';

class ImageNetwork extends StatelessWidget {
  final String path;
  final BoxFit? fit;
  final Widget? placeHolder;

  const ImageNetwork({Key? key, required this.path, this.fit, this.placeHolder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Hero(
            tag: path,
            child: CachedNetworkImage(
              placeholder: (context, url) => placeHolder ?? Container(),
              fit: fit ?? BoxFit.cover,
              imageUrl: path,
              errorWidget: (context, _, error) {
                return Center(child: Icon(Icons.error_outline_rounded, size: 6.0.w));
              },
            )),
        onTap: () {
          Get.dialog(Center(child: ImageView(image: path, showBack: true)));
        });
  }
}
