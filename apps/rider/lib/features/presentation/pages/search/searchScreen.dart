import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../common/utils/config.dart';
import '../../../../../../../../common/utils/go_to.dart';
import '../../../../../../../../common/widgets/progress_dialog.dart';
import '../../../../../../../../generated/assets.dart';
import '../../../../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../../../../../../libraries/init_app/run_app.dart';
import '../../../../../blocs/map_bloc.dart';
import '../../../../Models/address.dart';
import '../../../../Models/map_state.dart';
import '../../../../Models/placePredictions.dart';
import '../../../../common/assistants/requestAssistant.dart';
import '../../../../common/config/theme/colors.dart';
import '../../../../common/utils/constant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: MaterialText.bodyText1(
            "حدد وجهة ",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhite),
          ),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<MapState>(
              stream: si<MapBloc>().rxMapState,
              initialData: si<MapState>(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (snapshot.data == null || snapshot.data!.hideHeader) {
                  return const FadeInAnimation(curve: Curves.bounceInOut, child: SizedBox.shrink());
                }
                pickUpTextEditingController.text = data?.pinData.pickUpAddress ?? '';
                // dropOffTextEditingController.text = data?.pinData.destinationAddress ?? '';

                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: kGREY,
                        blurRadius: 1.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          RPadding.all16(
                            child: SvgPicture.asset(
                              Assets.iconsIcRoute,
                              height: 80.r,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, top: 25.0, right: 25.0, bottom: 20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: TextField(
                                          controller: pickUpTextEditingController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: " الموقع الحالي ",
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: const EdgeInsets.only(
                                                left: 11.0, top: 8.0, bottom: 8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: TextField(
                                          onChanged: (val) {
                                            findPlace(val);
                                          },
                                          controller: dropOffTextEditingController,
                                          decoration: InputDecoration(
                                            hintText: "  الى أين",
                                            fillColor: Colors.grey[100],
                                            filled: true,
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: const EdgeInsets.only(
                                                left: 11.0, top: 8.0, bottom: 8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        findPlace('');
                                        si<MapState>().isDestinationLoading = true;
                                        si<MapBloc>().sinkSetMapState(si<MapState>());
                                        si<MapState>().isDestinationLoading = false;
                                        si<MapState>().pinData.dropOffAddress = '';
                                        si<MapBloc>().sinkSetMapState(si<MapState>());
                                        setState(() {
                                          placePredictionList = [];
                                        });
                                      },
                                      icon: const Icon(Icons.close)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

          //tile for predictions

          (placePredictionList.isNotEmpty)
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0.0),
                      itemBuilder: (context, index) {
                        return Card(
                          child: PredictionTile(
                            placePredictions: placePredictionList[index],
                            onTap: () async {
                              si<MapState>().isDestinationLoading = true;
                              si<MapBloc>().sinkSetMapState(si<MapState>());
                              var destinationAddress =
                                  "${placePredictionList[index].mainText!}${placePredictionList[index].secondaryText}";
                              si<MapState>().isDestinationLoading = false;
                              si<MapState>().pinData.dropOffAddress = destinationAddress;
                              final response = await getPlaceAddressDetails(
                                  placePredictionList[index].placeId!, context);
                              final point =
                                  LatLng(response?.latitude ?? 0, response?.longitude ?? 0);
                              si<MapState>().pinData.destinationPoint = point;
                              si<MapState>().swapState();
                              si<MapState>().next = StatusTripMap.path;
                              si<MapBloc>().sinkSetMapState(si<MapState>());
                              si<MapBloc>().setMarker(
                                kDestinationMarker(si<MapState>().pinData.destinationPoint),
                              );
                              goToLocation(point);
                              Get.back();
                            },
                          ),
                        );
                      },
                      itemCount: placePredictionList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$kGoogleAPIKey&sessiontoken=1234567890&components=country:sy";

      var res = await RequestAssistant.getRequest(autoCompleteUrl);

      if (res == "failed") {
        return;
      }

      if (res["status"] == "OK") {
        var predictions = res["predictions"];

        var placesList = (predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();

        setState(() {
          placePredictionList = placesList;
        });
      }
    }
  }

  Future<Address?> getPlaceAddressDetails(String placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => const ProgressDialog(
              message: " الرجاء الانتظار...",
            ));

    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$kGoogleAPIKey";

    var res = await RequestAssistant.getRequest(placeDetailsUrl);

    Navigator.pop(context);

    if (res == "failed") {
      return null;
    }

    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      // Provider.of<AppData>(context, listen: false)
      //     .updateDropOffLocationAddress(address);
      log("This is Drop Off Location :: ");
      log("${address.placeName}");

      Navigator.pop(context, "obtainDirection");
      return address;
    }
    return null;
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;
  final Function() onTap;

  const PredictionTile({Key? key, required this.placePredictions, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(10.0),
      onPressed: onTap,
      child: Column(
        children: [
          const SizedBox(
            width: 10.0,
          ),
          Row(
            children: [
              const Icon(Icons.add_location),
              const SizedBox(
                width: 14.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "${placePredictions.mainText}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      "${placePredictions.secondaryText}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }
}
