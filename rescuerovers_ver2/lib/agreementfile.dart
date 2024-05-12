// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rescuerovers/DogsProfiles.dart';
// import 'package:rescuerovers/fosterhomes.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AgreementPage(),
//     );
//   }
// }

// class AgreementPage extends StatefulWidget {
//   @override
//   _AgreementPageState createState() => _AgreementPageState();
// }

// class _AgreementPageState extends State<AgreementPage> {
//   late SharedPreferences _prefs;
//   bool _agreed = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkAgreementStatus();
//   }

//   _checkAgreementStatus() async {
//     _prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _agreed = _prefs.getBool('agreed') ?? false;
//     });
//     if (_agreed) {
//       _navigateToNextScreen();
//     }
//   }

//   _saveAgreementStatus() async {
//     await _prefs.setBool('agreed', true);
//     _navigateToNextScreen();
//   }

//   _navigateToNextScreen() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => DogCreated()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('Agreement Page'),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(20.0),
//         children: [
//           Text(
//             'Terms and Conditions',
//             style: GoogleFonts.aboreto(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20.0),
//           Text(
//             'By creating a dog profile,your FosterHome will be visible to people,Creating a fake profile will lead to a ban.',
//             style: GoogleFonts.abel(fontSize: 16.0),
//           ),
//           SizedBox(height: 20.0),
//           ElevatedButton(
//             onPressed: _agreed
//                 ? null
//                 : () {
//                     _saveAgreementStatus();
//                   },
//             child: Text('Agree'),
//           ),
//         ],
//       ),
//     );
//   }
// }
