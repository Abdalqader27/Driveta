import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/round_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool lockInBackground = true;
  bool switchControl = false;

  var textHolder = 'Switch is OFF';

  Future<bool> saveSwitch(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("switch", value);
  }

  setLangPrefs(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang", value);
  }

  void putShared(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  Future getShared(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ///////// CHANGES HERE
    bool? val = prefs.getBool(key) == null ? false : (prefs.getBool(key));
    return val;
  }

  @override
  void initState() {
    super.initState();
    // getShared(widget.checkKey).then((value) {
    //   switchControl = value;
    // });
  }

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Switch is ON';
        // putShared(widget.checkKey, true);
      });
      print('Switch is ON');
      // DynamicTheme.of(context).setBrightness(Brightness.dark);
    } else {
      setState(() {
        switchControl = false;
        textHolder = 'Switch is OFF';
        // DynamicTheme.of(context).setBrightness(Brightness.light);
        // putShared(widget.checkKey, false);
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const RoundedAppBar(title: 'الاعدادات', subTitle: 'يمكنك تعديل ماتراه مناسبا'),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.withOpacity(0.5),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: PopupMenuButton(
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text('اللغات'),
                    ),
                    itemBuilder: (_) => [
                          const PopupMenuItem(
                            child: Text('العربية'),
                            value: 'ar',
                          ),
                          const PopupMenuItem(child: Text('English'), value: 'en'),
                        ],
                    onSelected: (value) => {
                          // helper.onLocaleChanged(Locale(value)),
                          // setLangPrefs(value)
                        }),
              ),
              subtitle: null,
              leading: const Icon(Icons.language),
            ),
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              trailing: Switch(
                value: true,
//                    onChanged: toggleSwitch,
                onChanged: (value) {
                  setState(() {
                    toggleSwitch(value);
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
              title: const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  'الوضع الليلي ',
                ),
              ),
              subtitle: null,
              leading: const Icon(Icons.style),
              onTap: () {},
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0),
            child: Text(
              'الحساب',
            ),
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'حسابي الشخصي ',
                    ),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'تعديل الحساب',
                    ),
                  ),
                  leading: const Icon(Icons.perm_identity),
                  onTap: () {},
                ),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'رقم الهاتف',
                    ),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      '+963 - 969  230  540 ',
                    ),
                  ),
                  leading: const Icon(Icons.phone),
                  onTap: () {},
                ),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      'تسحيل الخروج',
                    ),
                  ),
                  subtitle: null,
                  leading: const Icon(Icons.exit_to_app),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            //this right here
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(right: 30, top: 30, left: 30, bottom: 15),
                                      child: Text(
                                        'Attention',
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
//                  color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 30, top: 0, left: 30, bottom: 30),
                                      child: Text(
                                        'Do_you_really_want_to_log_out_of_your_account',
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
//                  color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 0),
                                            child: FlatButton(
                                              padding: const EdgeInsets.all(13.0),
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius: new BorderRadius.circular(15.0)),
                                              color: const Color(0xff1AA861),
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(
                                                    fontFamily: 'Tajawal',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                              onPressed: () => {
                                                Navigator.of(context).pop(),
                                              },
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 0),
                                            child: FlatButton(
                                              padding: const EdgeInsets.all(13.0),
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius: new BorderRadius.circular(15.0)),
                                              color: Colors.red,
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                    fontFamily: 'Tajawal',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                              onPressed: () => {
                                                Navigator.of(context).pop(),
                                              },
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
