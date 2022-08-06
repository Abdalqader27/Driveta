import 'package:design/design.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/generated/assets.dart';

import '../../../../../../data/models/store.dart';
import '../../../../../../injection/injection_network.dart';

class StoreMain extends StatefulWidget {
  final StoreDetails storeDetails;

  const StoreMain({Key? key, required this.storeDetails}) : super(key: key);

  @override
  State<StoreMain> createState() => _StoreMainState();
}

class _StoreMainState extends State<StoreMain> {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Image.network(
            kBase + widget.storeDetails.personalImage!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    Assets.iconsGroup3,
                    height: 200,
                    width: 200,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('لاتوجد صورة'),
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.store),
                title: RichText(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                    text: ' اسم صاحب المتجر :',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: '${widget.storeDetails.storeOwnerName}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
              const DottedLine(
                dashColor: kGrey3,
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: RichText(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                    text: ' الايميل :',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: '${widget.storeDetails.email}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              text: ' معلومات حول :',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: 'الخريطة',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SizedBox(
            height: 330,
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(widget.storeDetails.lat!),
                        double.parse(widget.storeDetails.long!)),
                    zoom: 14.4746,
                  ),
                  padding: const EdgeInsets.only(top: 30),
                  markers: _markers.values.toSet(),
                  onMapCreated: (GoogleMapController controller) {
                    _markers[MarkerId(widget.storeDetails.id!)] = Marker(
                        markerId: MarkerId(widget.storeDetails.id!),
                        position: LatLng(double.parse(widget.storeDetails.lat!),
                            double.parse(widget.storeDetails.long!)));
                    setState(() => {});
                  },
                ),
                // Container(
                //   color: kPRIMARY.withOpacity(.2),
                //   height: 380,
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
