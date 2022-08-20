import 'package:driver/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

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
  const factory LottieWidget.notFound2({
    double width,
    String path,
  }) = _NotFound2;
  const factory LottieWidget.empty({
    double width,
    String path,
  }) = _Empty;
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

class _NotFound2 extends LottieWidget {
  const _NotFound2({
    double width = 300,
    String path = Assets.lottieCarAnim,
  }) : super(path: path, width: width);
}

class _Empty extends LottieWidget {
  const _Empty({
    double width = 300,
    String path = Assets.lottieEmpty,
  }) : super(path: path, width: width);
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieWidget.empty(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('لايوجد عناصر'),
          )
        ],
      ),
    );
  }
}
