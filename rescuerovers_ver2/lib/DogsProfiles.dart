import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rescuerovers/editdogprofile.dart';
import 'package:rescuerovers/fosterhomes.dart';
import 'package:rescuerovers/petslistview.dart';
import 'package:rescuerovers/petslistview2.dart';

class DogCreated extends StatefulWidget {
  DogCreated({Key? key}) : super(key: key);

  @override
  State<DogCreated> createState() => _DogCreatedState();
}

class _DogCreatedState extends State<DogCreated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("assets/logo.png"),
              title: Text(
                "RescueRovers",
                style: GoogleFonts.aboreto(
                    fontSize: 33, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Dog Profile",
              style: GoogleFonts.aboreto(fontSize: 40),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Your Dogs:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("dogsprofiles")
                    .where("CreateduserUid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
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
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditDogProfilePage(
                                        docId: doc
                                            .id, // Pass the docId to EditDogProfilePage
                                        initialDogName: doc['dogname'],
                                        initialDogAge: doc['dogage'],
                                        initialDogBreed: doc['dogbreed'],
                                        initialDogCityLocation:
                                            doc['dogcitylocation'],
                                        initialDogDescription:
                                            doc['dogdescription'],
                                      )));
                        },
                        child: DogListVieww(
                          Dogname: doc['dogname'],
                          Dogage: doc['dogage'],
                          Dogbreed: doc['dogbreed'],
                          dogcitycloaction: doc['dogcitylocation'],
                          imgurl: doc['downloadUrl'],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FosterHomesPage()),
                  );
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.orange,
                      ),
                      Text(
                        "Create A Dog Profile",
                        style: GoogleFonts.oswald(fontSize: 20),
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.orange),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
