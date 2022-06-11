import 'dart:async';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver/features/data/models/drivers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:driver/features/data/models/allUsers.dart';
import 'package:geolocator/geolocator.dart';

String mapKey = "AIzaSyCeL6NXSWQJcyl0SjF3CZ0-3vN3q90aGc8";

User? firebaseUser;

Users? userCurrentInfo;

User? currentfirebaseUser;

late StreamSubscription<Position> homeTabPageStreamSubscription;

late StreamSubscription<Position> rideStreamSubscription;

// final assetsAudioPlayer = AssetsAudioPlayer();

late Position currentPosition;

late Drivers driversInformation;

String title = "";
double starCounter = 0.0;

String rideType = "";
