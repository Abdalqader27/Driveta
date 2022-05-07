import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../common/config/theme/colors.dart';
import '../../common/widgets/round_app_bar.dart';
import '../../generated/assets.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  _StateSupportScreen createState() => _StateSupportScreen();
}

class _StateSupportScreen extends State<SupportScreen> {
  bool sendingReportBool = false;
  final TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            const RoundedAppBar(
                title: 'المساعدة والدعم',
                subTitle: 'اذا كنت تعاني من اي مشكلة '
                    'دعنا '),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: SvgPicture.asset(
                      Assets.iconsGroup2,
                      width: 200.w,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'submit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                    child: TextField(
                      enabled: !sendingReportBool,
                      controller: _reportController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPRIMARY, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                      maxLines: null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: !sendingReportBool,
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: kPRIMARY,
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6), offset: const Offset(4, 4), blurRadius: 8.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                // if(_reportController.text.trim().length==0){
                                //   Fluttertoast.showToast(
                                //     msg: ''
                                //   );
                                // }
                                // else
                                // {
                                //   setState(() {
                                //     sendingReportBool=true;
                                //   });
                                //
                                //   bool res = await MyObjects.myApiRequest.report(context,_reportController.text,0);
                                //
                                //
                                //   if(res){
                                //     setState(() {
                                //       sendingReportBool=false;
                                //     });
                                //     _reportController.text="";
                                //     Fluttertoast.showToast(
                                //       msg: "${AppLocalizations.of(context).The_complaint_was_sent_successfully}",
                                //       textColor: Colors.white,
                                //       toastLength: Toast.LENGTH_LONG,
                                //       timeInSecForIos: 7,
                                //       gravity: ToastGravity.BOTTOM,
                                //       backgroundColor: MyColors.greenColor,
                                //     );
                                //
                                //   }
                                //   else{
                                //     setState(() {
                                //       sendingReportBool=false;
                                //     });
                                //     Fluttertoast.showToast(
                                //       msg: "${AppLocalizations.of(context).An_error_occurred_while_submitting_the_complaint}",
                                //       textColor: Colors.white,
                                //       toastLength: Toast.LENGTH_LONG,
                                //       timeInSecForIos: 7,
                                //       gravity: ToastGravity.BOTTOM,
                                //       backgroundColor: MyColors.greenColor,
                                //     );
                                //   }
                                //
                                // }
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        'Send',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      replacement: _progress(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _progress({double? padding}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
