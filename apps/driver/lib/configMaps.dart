import 'dart:async';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver/Models/drivers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:driver/Models/allUsers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
