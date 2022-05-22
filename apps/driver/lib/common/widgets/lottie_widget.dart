import 'package:driver/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  final double width;
  final String path;

  const LottieWidget({Key? key, required this.path, required this.width}) : super(key: key);

  const factory LottieWidget.loading({
    double width,
    String path,
  }) = _Loading;

  const factory LottieWidget.notFound({
    double width,
    String path,
  }) = _NotFound;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        path,
        width: width,
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
