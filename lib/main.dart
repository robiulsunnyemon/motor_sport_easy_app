import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:motor_sport_easy/motor_sport_easy_app.dart';
import 'app/routes/app_pages.dart';
import 'app/shared_pref_helper/shared_pref_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  requestPermission();
  final String? uid = await SharedPrefHelper.getUid();
  runApp(
    MotorSportEasyApp(
      initialRoute: uid != null? Routes.BOTTOM_NAVIGATION_BAR:Routes.LOGIN,

    ),
  );
}


void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print("Permission: ${settings.authorizationStatus}");
}