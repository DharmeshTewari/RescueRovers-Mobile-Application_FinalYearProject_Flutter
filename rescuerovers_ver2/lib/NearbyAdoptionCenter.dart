import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class Nearbyadoption extends StatefulWidget {
  Nearbyadoption({super.key});

  @override
  State<Nearbyadoption> createState() => _NearbyadoptionState();
}

class _NearbyadoptionState extends State<Nearbyadoption> {
  // Function to generate a random number between 1 and 50
  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(50) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '''
                Nearby Adoption Center
                ''',
                style: GoogleFonts.aboreto(
                    fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('userType', isEqualTo: 'Adoption Center')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    final List<QueryDocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        // Generate a random number
                        int randomNumber = generateRandomNumber();
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.location_on_sharp,
                                color: Color.fromARGB(255, 255, 174, 35),
                              ),
                              tileColor: Colors.grey[200],
                              title: Text(
                                doc['name'],
                                style: GoogleFonts.abel(),
                              ),
                              // Show the randomly generated number in the subtitle
                              subtitle: Text(
                                '$randomNumber km away  Contact Email:${doc["userEmail"]}',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
