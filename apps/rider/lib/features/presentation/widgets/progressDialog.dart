import 'package:flutter/material.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

class ProgressDialog extends StatelessWidget {
  final String message;
  const ProgressDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 6.0,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              const SizedBox(
                width: 26.0,
              ),
              Text(
                message,
                style: TextStyle(color: Colors.black, fontSize: 13.0.r),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
