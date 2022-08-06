import 'package:flutter/material.dart';

import '../../../../../../libraries/el_widgets/el_widgets.dart';

class ProgressMap extends StatelessWidget {
  const ProgressMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Opacity(
        opacity: 0.85,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          child: RPadding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                RPadding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: (100),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                RPadding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(' الرجاء اﻷنتظار'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
