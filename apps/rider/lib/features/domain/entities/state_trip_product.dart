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
}
