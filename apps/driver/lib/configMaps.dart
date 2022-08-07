import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

String mapKey = "AIzaSyCeL6NXSWQJcyl0SjF3CZ0-3vN3q90aGc8";

User? firebaseUser;

User? currentfirebaseUser;

late StreamSubscription<Position> homeTabPageStreamSubscription;

late StreamSubscription<Position> rideStreamSubscription;

// final assetsAudioPlayer = AssetsAudioPlayer();

String title = "";
double starCounter = 0.0;

String rideType = "";
