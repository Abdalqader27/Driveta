import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider/common/config/theme/colors.dart';

Widget circleButton(context, {heroTag, tooltip, icon, onPressed}) => Container(
      padding: const EdgeInsets.only(bottom: 10, left: (5), right: (5)),
      child: FloatingActionButton(
          backgroundColor: kPRIMARY,
          mini: true,
          isExtended: false,
          heroTag: heroTag,
          onPressed: onPressed,
          child: icon,
          tooltip: '$tooltip '),
    );

Widget circleCloseButton(context, {heroTag, tooltip, icon, onPressed}) => Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                const EdgeInsets.only(bottom: (32), left: (15), right: (15)),
            child: FloatingActionButton(
                backgroundColor: kPRIMARY,
                mini: false,
                isExtended: false,
                heroTag: heroTag,
                onPressed: onPressed,
                tooltip: 'الغاء ',
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
