import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rescuerovers/DogsProfiles.dart';
import 'package:rescuerovers/deatilsDog.dart';
import 'package:rescuerovers/petslistview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> _namesStream;
  late List<DocumentSnapshot> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _namesStream =
        FirebaseFirestore.instance.collection('dogsprofiles').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.asset("assets/logo.png"),
                title: Text(
                  "RescueRovers",
                  style: GoogleFonts.aboreto(
                      fontSize: 33, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '''WE wish for you to make a New Friend''',
                  style: GoogleFonts.aboreto(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black54),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      _searchDog(value);
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Search for a dog',
                      hintStyle: GoogleFonts.oswald(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 25,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "New Pets",
                      style: GoogleFonts.oswald(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                child: StreamBuilder(
                  stream: _namesStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final List<DocumentSnapshot<Object?>> documents =
                        _searchResults.isEmpty
                            ? snapshot.data!.docs
                            : _searchResults;
                    if (documents.isEmpty) {
                      return Center(child: Text('No dogs found'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DogDetails(
                                  Fosterhomesemail: doc["Fosterhomesemail"],
                                  dogAge: doc["dogage"],
                                  dogdiscription: doc["dogdescription"],
                                  dogBreed: doc["dogbreed"],
                                  dogName: doc["dogname"],
                                  dogCityLocation: doc["dogcitylocation"],
                                  imgUrl: doc["downloadUrl"],
                                  fosterhomesphonenumber:
                                      doc["FosterHomesPhoneNumber"],
                                ),
                              ),
                            );
                          },
                          child: DogListView(
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
            ],
          ),
        ),
      ),
    );
  }

  void _searchDog(String query) {
    setState(() {
      _searchResults = [];
    });

    if (query.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('dogsprofiles')
          .where('dogname', isEqualTo: query)
          .get()
          .then((snapshot) {
        setState(() {
          _searchResults = snapshot.docs;
        });
      });
    }
  }
}
