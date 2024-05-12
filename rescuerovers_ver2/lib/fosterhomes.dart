import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Login&Signup/ReqWidgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FosterHomesPage extends StatefulWidget {
  FosterHomesPage({super.key});

  @override
  State<FosterHomesPage> createState() => _FosterHomesPageState();
}

class _FosterHomesPageState extends State<FosterHomesPage> {
  final dognamecontroller = TextEditingController();

  final dogagecontroller = TextEditingController();

  final dogbreedcontroller = TextEditingController();
  final User = FirebaseAuth.instance.currentUser;
  final doglocationpathcontroller = TextEditingController();
  final dogdescriptioncontroller = TextEditingController();
  final fosterhomesphonenumbercontroller = TextEditingController();

  File? _file;
  String _downloadUrl = '';

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_file == null) {
      return;
    }

    final fileName = '${DateTime.now()}.png';
    final destination = 'files/$fileName';

    // Upload file to Firebase Storage
    await firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .putFile(_file!);

    // Get download URL
    final downloadUrl = await firebase_storage.FirebaseStorage.instance
        .ref(destination)
        .getDownloadURL();

    setState(() {
      _downloadUrl = downloadUrl;
    });

    // Update Firestore document
    await FirebaseFirestore.instance.collection('dogsprofiles').add({
      "dogname": dognamecontroller.text.trim(),
      "dogbreed": dogbreedcontroller.text.trim(),
      "dogage": dogagecontroller.text.trim(),
      "dogcitylocation": doglocationpathcontroller.text.trim(),
      "dogdescription": dogdescriptioncontroller.text.trim(),
      'downloadUrl': downloadUrl,
      "FosterHomesPhoneNumber": fosterhomesphonenumbercontroller.text.trim(),
      "CreateduserUid": User!.uid.trim(),
      "Fosterhomesemail": User!.email
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('File uploaded successfully!'),
    ));

    _formKey.currentState!.validate();
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Create your own pet profile",
                      style: GoogleFonts.aboreto(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFeildWidg(
                    // Add validator function
                    controller: dognamecontroller,
                    hinttext: "Dog Name",
                    Obsecuretext: false,
                    icon: Icon(
                      Icons.pets,
                      color: Color.fromARGB(255, 255, 174, 0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFeildWidg(
                      controller: dogagecontroller,
                      hinttext: "Dog Age",
                      Obsecuretext: false,
                      icon: Icon(
                        Icons.pets,
                        color: Color.fromARGB(255, 255, 174, 0),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFeildWidg(
                      controller: dogbreedcontroller,
                      hinttext: "Dog Breed",
                      Obsecuretext: false,
                      icon: Icon(
                        Icons.pets,
                        color: Color.fromARGB(255, 255, 174, 0),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFeildWidg(
                      controller: doglocationpathcontroller,
                      hinttext: "Foster Homes City",
                      Obsecuretext: false,
                      icon: Icon(
                        Icons.pets,
                        color: Color.fromARGB(255, 255, 174, 0),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFeildWidg(
                      controller: dogdescriptioncontroller,
                      hinttext: "Description about dog",
                      Obsecuretext: false,
                      icon: Icon(
                        Icons.pets,
                        color: Color.fromARGB(255, 255, 174, 0),
                      )),
                  TextFeildWidg(
                      controller: fosterhomesphonenumbercontroller,
                      hinttext: "Foster Homes Phone Number",
                      Obsecuretext: false,
                      icon: Icon(
                        Icons.pets,
                        color: Color.fromARGB(255, 255, 174, 0),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: _pickFile,
                    child: ListTile(
                      tileColor: Colors.grey[200],
                      leading: Icon(Icons.add),
                      title: Text(
                        "Upload dog image",
                        style: GoogleFonts.oswald(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Buttonsubmit(Textt: "Create Profile", onTap: _uploadFile),
                  SizedBox(
                    height: 50,
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
