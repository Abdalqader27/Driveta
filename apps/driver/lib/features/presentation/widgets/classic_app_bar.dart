import 'package:design/design.dart';

import 'close_widget.dart';

class ClassicAppBar extends StatelessWidget {
  final String title;
  final String? subTitle;

  const ClassicAppBar({Key? key, required this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CloseWidget(icon: Icons.arrow_back_ios_sharp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [SText.headlineMedium(title), if (subTitle != null) SText.bodyMedium(subTitle ?? "")],
          ),
        ),
        const SSizedBox.h42(),

        // AppBackButton(),
      ],
    );
  }
}
