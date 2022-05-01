import 'package:driver/configMaps.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class RatingTabPage extends StatefulWidget {
  @override
  _RatingTabPageState createState() => _RatingTabPageState();
}

class _RatingTabPageState extends State<RatingTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(5.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 22.0,
              ),
              Text(
                "your's Rating",
                style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold", color: Colors.black54),
              ),
              SizedBox(
                height: 22.0,
              ),
              Divider(
                height: 2.0,
                thickness: 2.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SmoothStarRating(
                rating: starCounter,
                color: Colors.green,
                allowHalfRating: true,
                starCount: 5,
                size: 45,

                // isReadOnly: true,
              ),
              SizedBox(
                height: 14.0,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 55.0, fontFamily: "Signatra", color: Colors.green),
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
