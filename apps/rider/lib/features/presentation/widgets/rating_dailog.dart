import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider/configMaps.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class RatingScreen extends StatefulWidget {
  final String? driverId;

  const RatingScreen({this.driverId});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 22.0,
              ),
              const Text(
                "Rate this Driver",
                style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold", color: Colors.black54),
              ),
              const SizedBox(
                height: 22.0,
              ),
              const Divider(
                height: 2.0,
                thickness: 2.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              SmoothStarRating(
                rating: starCounter,
                color: Colors.green,
                allowHalfRating: false,
                starCount: 5,
                size: 45,
                onRatingChanged: (value) {
                  starCounter = value;

                  if (starCounter == 1) {
                    setState(() {
                      title = "Very Bad";
                    });
                  }
                  if (starCounter == 2) {
                    setState(() {
                      title = "Bad";
                    });
                  }
                  if (starCounter == 3) {
                    setState(() {
                      title = "Good";
                    });
                  }
                  if (starCounter == 4) {
                    setState(() {
                      title = "Very Good";
                    });
                  }
                  if (starCounter == 5) {
                    setState(() {
                      title = "Excellent";
                    });
                  }
                },
              ),
              const SizedBox(
                height: 14.0,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 55.0, fontFamily: "Signatra", color: Colors.green),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  onPressed: () async {
                    DatabaseReference driverRatingRef =
                        FirebaseDatabase.instance.ref().child("drivers").child(widget.driverId!).child("ratings");

                    driverRatingRef.once().then((s) {
                      DataSnapshot snap = s.snapshot;

                      if (snap.value != null) {
                        double oldRatings = double.parse(snap.value.toString());
                        double addRatings = oldRatings + starCounter;
                        double averageRatings = addRatings / 2;
                        driverRatingRef.set(averageRatings.toString());
                      } else {
                        driverRatingRef.set(starCounter.toString());
                      }
                    });

                    Navigator.pop(context);
                  },
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Submit",
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
