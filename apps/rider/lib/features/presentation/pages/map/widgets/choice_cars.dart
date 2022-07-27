import 'package:design/design.dart';
import 'package:rider/common/config/theme/colors.dart';

import '../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../data/models/direct_details.dart';
import '../../../manager/container.dart';

class ChoiceCarsWidget extends StatelessWidget {
  final double height;
  final DirectionDetails? directionDetails;
  final ValueChanged<CarDetails>? onTap;

  const ChoiceCarsWidget({
    Key? key,
    required this.height,
    this.directionDetails,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        margin: const EdgeInsets.all(8),
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.9),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.0),
          child: Column(
            children: [
              const MaterialText.subTitle1('تفاصيل الرحلة'),
              Row(
                children: [
                  _PanelItem(
                    title: 'المسافة',
                    subtitle: directionDetails?.distanceText ?? '',
                    iconData: Icons.polyline_sharp,
                  ),
                  _PanelItem(
                    title: 'الوقت',
                    subtitle: directionDetails?.durationText ?? '',
                    iconData: Icons.lock_clock,
                  ),
                ],
              ),

              const MaterialText.subTitle1('اختر السيارة'),
              // Expanded(child: Container()),
              Expanded(
                child: SizedBox(
                  height: height * 0.6,
                  child: GetVehicleTypesContainer(
                      builder: (context, List<CarDetails> data) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          final cartDetails = data[i];
                          return CarItemWidget(
                            onTap: () => onTap?.call(cartDetails),
                            directionDetails: directionDetails,
                            carDetails: cartDetails,
                          );
                        });
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CarItemWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final CarDetails carDetails;
  final DirectionDetails? directionDetails;

  const CarItemWidget({
    Key? key,
    this.onTap,
    required this.carDetails,
    required this.directionDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPRIMARY.withOpacity(.1),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 110,
          child: Column(
            children: [
              // Image.asset(
              //   carDetails.image,
              //   height: 50.0,
              //   width: 80.0,
              // ),
              Expanded(child: Container()),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carDetails.item1,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Text(
                ((directionDetails != null)
                    ? ' ${calcPrice(
                        start: carDetails.item2,
                        distance: directionDetails?.distanceValue ?? 0,
                      )} ل.س'
                    : ''),
                style: const TextStyle(),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  int calcPrice({required int distance, required int start}) {
    int factor = start ~/ 2;
    var temp = (distance / 250.0).round();
    return start + temp * factor;
  }
}

class CarDetails {
  CarDetails({
    required this.item1,
    required this.item2,
  });

  final String item1;
  final int item2;

  factory CarDetails.fromJson(Map<String, dynamic> json) => CarDetails(
        item1: json["item1"],
        item2: json["item2"],
      );

  Map<String, dynamic> toJson() => {
        "item1": item1,
        "item2": item2,
      };
}

// List<CarDetails> carsList = [
//   const CarDetails(
//     image: "images/bike.png",
//     type: 'bike',
//     price: 600,
//     name: 'دراجة',
//   ),
//   const CarDetails(
//     image: "images/ubergo.png",
//     type: 'uber-go',
//     price: 1000,
//     name: 'اوبر - غو',
//   ),
//   const CarDetails(
//     image: "images/uberx.png",
//     type: 'uber-x',
//     price: 1000,
//     name: 'اوبر -اكس',
//   ),
// ];

class _PanelItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;

  const _PanelItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              iconData,
              color: kPRIMARY,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: SText.bodyMedium(title, textAlign: TextAlign.center),
              ),
            ),
            Center(
              child: SText.bodyMedium(subtitle, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
