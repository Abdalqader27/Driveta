import 'package:design/design.dart';
import 'package:rider/common/config/theme/colors.dart';

import '../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../data/models/direct_details.dart';
import '../../../manager/container.dart';

class ChoiceCarsWidget extends StatefulWidget {
  final double height;
  final DirectionDetails? directionDetails;
  final ValueChanged<CarDetails>? onTap;
  final bool? isChosen;

  const ChoiceCarsWidget({
    Key? key,
    required this.height,
    this.directionDetails,
    this.isChosen,
    this.onTap,
  }) : super(key: key);

  @override
  State<ChoiceCarsWidget> createState() => _ChoiceCarsWidgetState();
}

class _ChoiceCarsWidgetState extends State<ChoiceCarsWidget> {
  int selectIdx = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: widget.height,
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
                  subtitle: widget.directionDetails?.distanceText
                          .replaceAll('km', 'كم') ??
                      '',
                  iconData: Icons.polyline_sharp,
                ),
                _PanelItem(
                  title: 'الوقت',
                  subtitle: widget.directionDetails?.durationText
                          .replaceAll('mins', 'د') ??
                      '',
                  iconData: Icons.lock_clock,
                ),
              ],
            ),

            const MaterialText.subTitle1('اختر السيارة'),
            // Expanded(child: Container()),
            Expanded(
              child: SizedBox(
                height: widget.height * 0.6,
                child: GetVehicleTypesContainer(
                    builder: (context, List<CarDetails> data) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        final cartDetails = data[i];
                        return CarItemWidget(
                          clickIndex: selectIdx,
                          onTap: () {
                            setState(() => selectIdx = i);
                            widget.onTap?.call(cartDetails);
                          },
                          directionDetails: widget.directionDetails,
                          index: widget.isChosen == null ? null : i,
                          carDetails: cartDetails,
                        );
                      });
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CarItemWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final CarDetails carDetails;
  final DirectionDetails? directionDetails;
  final int? index;
  final int clickIndex;

  const CarItemWidget({
    Key? key,
    this.onTap,
    this.index,
    this.clickIndex = 0,
    required this.carDetails,
    required this.directionDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: index == null
          ? kPRIMARY.withOpacity(.1)
          : clickIndex == index
              ? kPRIMARY
              : kPRIMARY.withOpacity(.1),
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
                    style: TextStyle(
                        fontSize: 15.0,
                        color: index == null
                            ? kBlack
                            : clickIndex == index
                                ? Colors.white
                                : kBlack),
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
                style: TextStyle(
                    color: index == null
                        ? kBlack
                        : clickIndex == index
                            ? Colors.white
                            : kBlack),
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
