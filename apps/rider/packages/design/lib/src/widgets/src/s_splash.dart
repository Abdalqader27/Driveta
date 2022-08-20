/// File created by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022
part of widgets;

abstract class SSplash extends StatelessWidget {
  final String svgPath;

  const SSplash({Key? key, required this.svgPath}) : super(key: key);

  factory SSplash.normal({
    Key? key,
    Color? backgroundColor,
    required String svgPath,
    Color? color,
  }) {
    return _Normal(
      backgroundColor: backgroundColor,
      svgPath: svgPath,
      color: color,
    );
  }

  factory SSplash.loading({
    Key? key,
    Color? backgroundColor,
    required String svgPath,
    Color? color,
  }) {
    return _Loading(
      backgroundColor: backgroundColor,
      svgPath: svgPath,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Normal(
      svgPath: svgPath,
    );
  }
}

class _Normal extends SSplash {
  final Color? backgroundColor;
  final String svgPath;
  final Color? color;

  const _Normal({
    Key? key,
    this.backgroundColor,
    required this.svgPath,
    this.color,
  }) : super(key: key, svgPath: svgPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          height: 160.0,
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}

class _Loading extends SSplash {
  final Color? backgroundColor;
  final String svgPath;
  final Color? color;

  const _Loading({
    Key? key,
    this.backgroundColor,
    required this.svgPath,
    this.color,
  }) : super(key: key, svgPath: svgPath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            width: 500,
            height: 200,
            color: color ?? Colors.white,
          ),
          const SSizedBox.v32(),
          CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
          ),
        ],
      )),
    );
  }
}
