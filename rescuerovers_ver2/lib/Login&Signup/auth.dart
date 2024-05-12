import 'package:flutter/material.dart';
import 'package:rescuerovers/Login&Signup/Login.dart';
import 'package:rescuerovers/Login&Signup/Register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showloginpage = true;
  void tooglescreen() {
    setState(() {
      showloginpage = !showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return LoginPage(showregisterpage: tooglescreen);
    } else {
      return RegisterPage(showloginpage: tooglescreen);
    }
  }
}
