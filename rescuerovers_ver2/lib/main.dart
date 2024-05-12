import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rescuerovers/Login&Signup/main_page.dart';
import 'package:rescuerovers/Onboarding/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login&Signup/Register.dart';
import "Login&Signup/Login.dart";

bool show = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool('ON_BOARDING') ?? true;
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyBi4Bj7JRpv4kKRABvCixRlPjEJhP256R8",
              appId: "1:633754370973:android:e0644850ac8f8c84ade574",
              messagingSenderId: "633754370973",
              projectId: "dogadopt-e284a",
              storageBucket: "dogadopt-e284a.appspot.com"),
        )
      : Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RescueRovers',
        theme: ThemeData(primarySwatch: Colors.yellow),
        // home: show ? OnBoardingScreen() : RegisterPage(),
        home: show ? OnBoardingScreen() : MainPage());
  }
}
