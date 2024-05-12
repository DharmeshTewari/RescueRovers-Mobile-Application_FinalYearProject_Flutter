import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Login&SIgnup/ReqWidgets.dart';

class EditDogProfilePage extends StatefulWidget {
  final String docId;
  final String initialDogName;
  final String initialDogAge;
  final String initialDogBreed;
  final String initialDogCityLocation;
  final String initialDogDescription;

  EditDogProfilePage({
    required this.docId,
    required this.initialDogName,
    required this.initialDogAge,
    required this.initialDogBreed,
    required this.initialDogCityLocation,
    required this.initialDogDescription,
  });

  @override
  _EditDogProfilePageState createState() => _EditDogProfilePageState();
}

class _EditDogProfilePageState extends State<EditDogProfilePage> {
  late TextEditingController _dogNameController;
  late TextEditingController _dogAgeController;
  late TextEditingController _dogBreedController;
  late TextEditingController _dogCityLocationController;
  late TextEditingController _dogDescriptionController;

  @override
  void initState() {
    super.initState();
    _dogNameController = TextEditingController(text: widget.initialDogName);
    _dogAgeController = TextEditingController(text: widget.initialDogAge);
    _dogBreedController = TextEditingController(text: widget.initialDogBreed);
    _dogCityLocationController =
        TextEditingController(text: widget.initialDogCityLocation);
    _dogDescriptionController =
        TextEditingController(text: widget.initialDogDescription);
  }

  void _deleteDogProfile() {
    FirebaseFirestore.instance
        .collection('dogsprofiles')
        .doc(widget.docId)
        .delete()
        .then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      print('Failed to delete dog profile: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Edit Dog Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _dogNameController,
                decoration: InputDecoration(
                    labelText: 'Dog Name', labelStyle: GoogleFonts.oswald()),
              ),
              TextFormField(
                controller: _dogAgeController,
                decoration: InputDecoration(
                    labelText: 'Dog Age', labelStyle: GoogleFonts.oswald()),
              ),
              TextFormField(
                controller: _dogBreedController,
                decoration: InputDecoration(
                    labelText: 'Dog Breed', labelStyle: GoogleFonts.oswald()),
              ),
              TextFormField(
                controller: _dogCityLocationController,
                decoration: InputDecoration(
                    labelText: 'City Location',
                    labelStyle: GoogleFonts.oswald()),
              ),
              TextFormField(
                controller: _dogDescriptionController,
                decoration: InputDecoration(
                    labelText: 'Description', labelStyle: GoogleFonts.oswald()),
              ),
              SizedBox(height: 16),
              Buttonsubmit(
                  Textt: "Save Changes",
                  onTap: () {
                    _updateDogProfile();
                  }),
              Buttonsubmit(
                  Textt: "Delete Dog Profile",
                  onTap: () {
                    _deleteDogProfile();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _updateDogProfile() {
    FirebaseFirestore.instance
        .collection('dogsprofiles')
        .doc(widget.docId)
        .update({
      'dogname': _dogNameController.text,
      'dogage': _dogAgeController.text,
      'dogbreed': _dogBreedController.text,
      'dogcitylocation': _dogCityLocationController.text,
      'dogdescription': _dogDescriptionController.text,
    }).then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      print('Failed to update dog profile: $error');
    });
  }

  @override
  void dispose() {
    _dogNameController.dispose();
    _dogAgeController.dispose();
    _dogBreedController.dispose();
    _dogCityLocationController.dispose();
    _dogDescriptionController.dispose();
    super.dispose();
  }
}
