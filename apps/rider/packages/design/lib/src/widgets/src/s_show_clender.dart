/// File created by
/// Abed <Abed-supy-io>
/// on 28 /Apr/2022
part of widgets;

enum sCalenderTheme { dark, light }

Future<void> sShowCalender({
  required BuildContext context,
  required ValueChanged<DateTime?> onChange,
  required DateTime initTime,
  DateTime? lastDate,
  ColorScheme? colorScheme,
  RoundedRectangleBorder? shape,
  sCalenderTheme theme = sCalenderTheme.light,
}) async {
  onChange(await showDatePicker(
    initialDate: initTime,
    lastDate: lastDate ?? DateTime(2040),
    firstDate: initTime,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    context: context,
    builder: (BuildContext context, Widget? child) {
      if (theme == sCalenderTheme.light) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogTheme: DialogTheme(shape: shape ?? SShapes.sR16),
            colorScheme: colorScheme ??
                ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                  surface: Theme.of(context).primaryColor,
                  onSurface: Colors.black,
                ),
          ),
          child: child!,
        );
      } else if (theme == sCalenderTheme.dark) {
        return Theme(
          data: ThemeData.dark().copyWith(
            dialogTheme: DialogTheme(shape: shape ?? SShapes.sR16),
            colorScheme: colorScheme ??
                ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                  surface: Theme.of(context).primaryColor,
                  onSurface: Colors.white,
                ),
          ),
          child: child!,
        );
      }
      return const SizedBox.shrink();
    },
  ));
}
