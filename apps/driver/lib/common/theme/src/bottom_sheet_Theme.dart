import 'package:design/design.dart';

const _bottomSheetTheme = BottomSheetThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(14),
      topRight: Radius.circular(14),
    ),
  ),
);

BottomSheetThemeData get kBottomSheetTheme => _bottomSheetTheme;
