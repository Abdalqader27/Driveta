import 'package:driver/common/assistants/assistantMethods.dart';
import 'package:driver/configMaps.dart';
import 'package:flutter/material.dart';

class CollectFareDialog extends StatelessWidget {
  final String paymentMethod;
  final int fareAmount;

  CollectFareDialog({required this.paymentMethod, required this.fareAmount});

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            Text(
              "Trip Fare (" + rideType.toUpperCase() + ")",
              style: const TextStyle(fontSize: 16.0, fontFamily: "Brand Bold"),
            ),
            const SizedBox(
              height: 22.0,
            ),
            const Divider(
              thickness: 4.0,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              "\$$fareAmount",
              style: const TextStyle(fontSize: 55.0, fontFamily: "Brand Bold"),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                "This is the total trip amount, it has been charged to the rider.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RaisedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);

                  AssistantMethods.enableHomeTabLiveLocationUpdates();
                },
                color: Colors.deepPurpleAccent,
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Collect Cash",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Icon(
                        Icons.attach_money,
                        color: Colors.white,
                        size: 26.0,
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
    );
  }
}
