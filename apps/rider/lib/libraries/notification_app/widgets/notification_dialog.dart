import 'package:flutter/material.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

class NotificationDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String textButtonConfirm;
  final Function() onConfirm;

  const NotificationDialog(
      {Key? key, required this.title, required this.subTitle, required this.textButtonConfirm, required this.onConfirm})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
      content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 20.0.h,
              ),
              ElevatedButton(
                onPressed: onConfirm,
                child: Text(textButtonConfirm),
              )
            ],
          ),
          padding: EdgeInsets.all(15.0.sp),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            // border: Border.all(
            //     width: 1, color: Theme.of(context).colorScheme.secondary),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
