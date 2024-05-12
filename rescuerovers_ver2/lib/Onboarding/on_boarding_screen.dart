import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rescuerovers/Login&Signup/Login.dart';
import 'package:rescuerovers/Login&Signup/Register.dart';
import 'package:rescuerovers/Login&Signup/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rescuerovers/Login&Signup/auth.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: IntroductionScreen(
          pages: [
            commonPageViewModel(
              "RescueRovers: Find Your Furry Companion Today!",
              "Welcome to RescueRovers, where wagging tails and loving hearts unite! Discover your perfect canine companion and make a difference in a dog's life.",
              "assets/dog1.png",
            ),
            commonPageViewModel(
              "RescueRovers: Unleash Love, One Adoption at a Time!",
              "Join RescueRovers and embark on a journey to find your loyal companion, making a difference in the lives of rescue dogs everywhere.",
              "assets/dog2.jpg",
            ),
            commonPageViewModel(
              "RescueRovers: Pawsitively Changing Lives, One Adoption at a Time!",
              "Welcome to RescueRovers, where every adoption story begins with a wagging tail and a heart full of hope.",
              "assets/dog3.png",
            ),
          ],
          dotsDecorator: DotsDecorator(
              size: const Size(10, 10),
              activeColor: Color.fromARGB(255, 255, 174, 0),
              activeSize: const Size(20, 10),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
          showDoneButton: true,
          done: Text(
            "Done",
            style: GoogleFonts.aboreto(
              color: Color.fromARGB(255, 255, 174, 0),
              fontSize: 20,
            ),
          ),
          showNextButton: true,
          next: const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Colors.black87,
          ),
          showSkipButton: true,
          skip: Text(
            "Skip",
            style: GoogleFonts.aboreto(
              fontSize: 20,
              color: Color.fromARGB(255, 255, 174, 0),
            ),
          ),
          onDone: () => onDone(context),
        ),
      ),
    );
  }

  PageViewModel commonPageViewModel(title, bodyText, image) {
    return PageViewModel(
      title: title,
      body: bodyText,
      image: Image.asset(image),
      decoration: PageDecoration(
          titleTextStyle:
              GoogleFonts.oswald(fontSize: 25, fontWeight: FontWeight.bold)),
    );
  }

  void onDone(context) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool("ON_BOARDING", false);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
  }
}
// but when we restart a app they again show onbording screen ,
// when we have start app second time we need  directly
//  go to home screen fot that we used the Shared preferences plugin,