import 'dart:convert';

import 'package:design/design.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rider/common/config/theme/colors.dart';

import '../../../../generated/assets.dart';
import '../../../data/models/user.dart';
import 'favourite.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kPRIMARY, kPRIMARY.withOpacity(.7)],
                    ),
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 110.0,
                    ),
                    CircleAvatar(
                      radius: 65.0,
                      child: SvgPicture.asset(
                        Assets.iconsUser,
                        width: 125,
                        height: 125,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('${widget.user.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "رصيدك : ${widget.user.balance}  ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    )
                  ]),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.grey[200],
                  child: Center(
                      child: Card(
                          margin:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                              height: 220.0,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: const Text(
                                        "المعلومات ",
                                        style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey[300],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          color: kPRIMARY,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "الهاتف",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Text(
                                                "${(json.decode(widget.user.phoneNumber!) as Map)['formatInternational']}",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.mail,
                                          color: kPRIMARY,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "الايميل",
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              "${widget.user.email}",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[400],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.device_hub,
                                          color: kPRIMARY,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "الجنس",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              '${widget.user.sexType == 0 ? 'ذكر' : 'انثى'}',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[400],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )))),
                ),
              ),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: 20.0,
              right: 20.0,
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        Text(
                          'اسم المستخدم',
                          style: TextStyle(
                              color: Colors.grey[400], fontSize: 14.0),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "${widget.user.userName}",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    )),
                    GestureDetector(
                      onTap: () => Get.to(() => FavouritePage()),
                      child: Container(
                        child: Column(children: [
                          Text(
                            'المفضلة ',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 14.0),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          const Text(
                            '3',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ))),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
