import 'package:driver/common/theme/src/text_theme.dart';

import 'icon_theme.dart';
import 'package:design/design.dart';

final _appbarTheme = AppBarTheme(
    color: kWhite,
    titleTextStyle: kTextTheme.headline6!.copyWith(color: kPrimaryColor),
    centerTitle: false,
    iconTheme: kIconTheme);

AppBarTheme get kAppBarTheme => _appbarTheme;
