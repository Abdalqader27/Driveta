/// File created by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022
part of widgets;

class SErrorScreen extends StatelessWidget {
  final String error;
  final String message;
  final String svgPath;
  final String retryText;
  final Function() retry;

  const SErrorScreen({
    Key? key,
    required this.retry,
    required this.error,
    required this.message,
    required this.svgPath,
    required this.retryText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPath, //Assets.iconsSmile,
              width: 80,
              height: 80,
            ),
            const SSizedBox.v16(),
            SText.titleMedium(
              'مع الاسف !',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SSizedBox.v8(),
            SizedBox(
              width: context.widthPx / 1.5,
              child: SText.titleMedium(
                'لقد حدث خطأ ما ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
            const SSizedBox.v16(),

            /// TODO buttons
            OutlinedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                SShapes.sR4B1(),
              )),
              onPressed: retry,
              child: SText.titleMedium(
                'إعادة المحاولة',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
