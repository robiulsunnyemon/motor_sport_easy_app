import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motor_sport_easy/motor_sport_easy_app.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MotorSportEasyApp()
  );
}
