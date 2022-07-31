import '../../data/models/driver.dart';

class StateTripProduct {
  final Driver? driver;
  final String title;
  final String titleSpan;
  final int number;

  StateTripProduct(
      {this.driver,
      this.title = 'السائق',
      this.titleSpan = " في طريقه اليك",
      this.number = 0});

  copyWith({Driver? driver, String? title, String? titleSpan, int? number}) {
    return StateTripProduct(
      driver: driver ?? this.driver,
      title: title ?? this.title,
      titleSpan: titleSpan ?? this.titleSpan,
      number: number ?? this.number,
    );
  }

  String getTitle() {
    switch (number) {
      case 0:
        return 'السائق ';
      case 1:
        return 'لقد وصل ';
      case 2:
        return 'بدأت ';
      case 3:
        return 'تمت ';
      default:
        return title;
    }
  }

  String getTitleSpan() {
    switch (number) {
      case 0:
        return ' في طريقه اليك';
      case 1:
        return 'السائق';
      case 2:
        return 'الرحلة';
      case 3:
        return 'الرحلة بنجاح ';
      default:
        return titleSpan;
    }
  }
}
