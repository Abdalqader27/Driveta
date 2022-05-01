import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'close_widget.dart';
import 'lottie_widget.dart';

class ImageView extends StatelessWidget {
  final String image;
  final bool showBack;

  const ImageView({Key? key, required this.image, this.showBack = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PhotoView(
            maxScale: 3.0,
            minScale: PhotoViewComputedScale.contained,
            loadingBuilder: (_, __) {
              return const Center(child: LottieWidget.loading());
            },
            imageProvider: CachedNetworkImageProvider(image)),
        if (showBack)
          Positioned(
              top: 100.r,
              left: 10.r,
              child: const CloseWidget(
                icon: Icons.arrow_back_ios_outlined,
              ))
      ],
    ));
  }
}
