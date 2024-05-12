import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Assuming this is your login/signup page
import 'package:rescuerovers/BottomNavBar.dart';
import 'package:rescuerovers/Bottomforfoster.dart';
import 'package:rescuerovers/Login&Signup/auth.dart';
import 'package:rescuerovers/fosterhomes.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            // User is logged in
            User? user = snapshot.data;
            if (user != null) {
              // Check user type from Firestore
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (userSnapshot.hasData) {
                    String userType = userSnapshot.data!['userType'];
                    if (userType == 'Adoption Center') {
                      // Navigate to adoption center screen
                      return BottomNavbarrr();
                    } else if (userType == 'Foster Home') {
                      // Navigate to foster home screen
                      return BottomForFosters();
                    } else {
                      // Handle other user types as needed
                      return Center(
                        child: Text('Unknown user type'),
                      );
                    }
                  } else {
                    // Handle error fetching user data
                    return Center(
                      child: Text('Error fetching user data'),
                    );
                  }
                },
              );
            } else {
              // Handle null user
              return AuthPage();
            }
          } else {
            // User is not logged in
            return AuthPage();
          }
        },
      ),
    );
  }
}
