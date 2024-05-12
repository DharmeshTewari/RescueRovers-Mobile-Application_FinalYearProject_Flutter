import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rescuerovers/DogsProfiles.dart';
import 'package:rescuerovers/agreementfile.dart';
import 'package:rescuerovers/fosterhomes.dart';

class UserDetailsPage extends StatelessWidget {
  UserDetailsPage({super.key});
  final User = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Profile",
                    style: GoogleFonts.aboreto(fontSize: 40),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.person_2_sharp,
                    size: 250,
                    color: Color.fromARGB(255, 255, 174, 0),
                  ),
                  Text(
                    "Logined As : ${User!.email} ",
                    style: GoogleFonts.oswald(fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.logout),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Logout",
                              style: GoogleFonts.oswald(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => DogCreated()));
                  //   },
                  //   // child: Container(
                  //   //   width: MediaQuery.of(context).size.width,
                  //   //   height: 80,
                  //   //   decoration: BoxDecoration(color: Colors.white),
                  //   //   child: Row(
                  //   //     children: [
                  //   //       Padding(
                  //   //         padding: const EdgeInsets.all(8.0),
                  //   //         child: Icon(Icons.pets),
                  //   //       ),
                  //   //       Padding(
                  //   //         padding: const EdgeInsets.all(8.0),
                  //   //         child: Text(
                  //   //           "Create a Dog Profile",
                  //   //           style: GoogleFonts.oswald(fontSize: 20),
                  //   //         ),
                  //   //       ),
                  //   //     ],
                  //   //   ),
                  //   // ),
                  // ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
