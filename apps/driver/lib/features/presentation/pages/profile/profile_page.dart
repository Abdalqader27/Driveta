import 'dart:convert';

import 'package:design/design.dart';
import 'package:driver/common/config/theme/colors.dart';
import 'package:driver/features/presentation/widgets/round_app_bar.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/generated/assets.dart';
import 'package:driver/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../data/models/profile.dart';
import '../../manager/container.dart';
import '../sgin_in/login_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProfileContainer(builder: (context, DriverProfile data) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedAppBar(
                title: 'الملف الشخصي',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const SSizedBox.v16(),

                      SImageNetworkCache(
                        progressSize: Size(160, 160),
                        path: data.personalImage,
                        errorWidget: SvgPicture.asset(
                          Assets.iconsUser,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SmoothStarRating(
                        rating: data.rate.toDouble(),
                        color: kPRIMARY,
                        allowHalfRating: true,
                        starCount: 5,
                        size: 25,

                        // isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data.name,
                        style: const TextStyle(
                            fontSize: 35.0,
                            fontFamily: "Signatra",
                            color: kPRIMARY),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      InfoCard(
                        text: (json.decode(data.phoneNumber)
                            as Map)['formatInternational'],
                        icon: Icons.phone,
                        onPressed: () async {
                          print("this is phone.");
                        },
                      ),
                      // InfoCard(
                      //   text: data. ?? '',
                      //   icon: Icons.email,
                      //   onPressed: () async {
                      //     print("this is email.");
                      //   },
                      // ),
                      InfoCard(
                        text:
                            "${data.vehicleColor} - ${data.vehicleModelName} - ${data.vehicleNumber}",
                        icon: Icons.car_repair,
                        onPressed: () async {
                          print("this is car info.");
                        },
                      ),
                      CupertinoButton(
                        onPressed: () {
                       
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.idScreen, (route) => false);
                        },
                        child: const Card(
                          color: kPRIMARY,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 110.0),
                          child: ListTile(
                            trailing: Icon(
                              Icons.follow_the_signs_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Sign out",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Brand Bold',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  Function() onPressed;

  InfoCard({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black87,
          ),
          title: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
