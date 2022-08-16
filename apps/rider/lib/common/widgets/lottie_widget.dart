import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';

class LottieWidget extends StatelessWidget {
  final double width;
  final String path;

  const LottieWidget({Key? key, required this.path, required this.width})
      : super(key: key);

  const factory LottieWidget.loading({
    double width,
    String path,
  }) = _Loading;

  const factory LottieWidget.notFound({
    double width,
    String path,
  }) = _NotFound;
  const factory LottieWidget.empty({
    double width,
    String path,
  }) = _Empty;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        path,
        width: width.r,
      ),
    );
  }
}

class _Loading extends LottieWidget {
  const _Loading({
    double width = 160.0,
    String path = Assets.lottieNewLoader,
  }) : super(path: path, width: width);
}

class _NotFound extends LottieWidget {
  const _NotFound({
    double width = 300,
    String path = Assets.lottieErorr,
  }) : super(path: path, width: width);
}

class _Empty extends LottieWidget {
  const _Empty({
    double width = 300,
    String path = Assets.lottieEmpty,
  }) : super(path: path, width: width);
}

class LottieLoading extends StatelessWidget {
  const LottieLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          'lotti_files/111034-maps-ciudad-inteligente.json',
          width: 300,
        ),
        const Text('الرجاء الانتظار')
      ],
    );
  }
}
