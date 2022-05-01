import 'package:driver/features/auth/presentation/pages/sgin_in/login_screen.dart';
import 'package:driver/common/config/theme/colors.dart';
import 'package:driver/common/widgets/round_app_bar.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/generated/assets.dart';
import 'package:driver/libraries/el_widgets/widgets/responsive_sized_box.dart';
import 'package:driver/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundedAppBar(
              title: driversInformation.name ?? '',
              subTitle: title + " الساىق",
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
                    const RSizedBox.v16(),
                    SvgPicture.asset(
                      Assets.iconsUser,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SmoothStarRating(
                      rating: starCounter,
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
                      title,
                      style: const TextStyle(fontSize: 55.0, fontFamily: "Signatra", color: kPRIMARY),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    InfoCard(
                      text: driversInformation.phone ?? '',
                      icon: Icons.phone,
                      onPressed: () async {
                        print("this is phone.");
                      },
                    ),
                    InfoCard(
                      text: driversInformation.email ?? '',
                      icon: Icons.email,
                      onPressed: () async {
                        print("this is email.");
                      },
                    ),
                    InfoCard(
                      text: driversInformation.car_color ??
                          '' " " +
                              "${driversInformation.car_model ?? ''}"
                                  " " +
                              "${driversInformation.car_number}",
                      icon: Icons.car_repair,
                      onPressed: () async {
                        print("this is car info.");
                      },
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Geofire.removeLocation(currentfirebaseUser!.uid);
                        rideRequestRef?.onDisconnect();
                        rideRequestRef?.remove();
                        rideRequestRef = null;

                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                      },
                      child: const Card(
                        color: kPRIMARY,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 110.0),
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
        ),
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
          title: Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontFamily: 'Brand Bold',
            ),
          ),
        ),
      ),
    );
  }
}
