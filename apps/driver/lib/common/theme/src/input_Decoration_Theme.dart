import 'package:design/design.dart';

final _inputDecorationTheme = InputDecorationTheme(
  fillColor: kGrey1,
  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  enabledBorder: _getOutlineBorder(width: 1.0, color: kGrey2),
  border: _getOutlineBorder(color: kGrey3),
  focusedBorder: _getOutlineBorder(width: 0.0, color: kGrey3),
);

InputDecorationTheme get kInputDecorationTheme => _inputDecorationTheme;

OutlineInputBorder _getOutlineBorder({double? width, required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: BorderSide(
      width: width ?? 1,
      color: color,
    ),
  );
}
