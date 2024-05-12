import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ReqWidgets.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key, required this.showloginpage});
  final VoidCallback showloginpage;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final confirmpasscontroller = TextEditingController();
  final namecontroller = TextEditingController();

  String? _userType; // To store the selected user type

  Future signup() async {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      if (passconfirmed()) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroller.text.trim(),
                password: passcontroller.text.trim());
        // Check user type and store data accordingly
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
          "userEmail": emailcontroller.text.trim(),
          "userType": _userType,
          "name": namecontroller.text.trim()
        });
      }
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Error While Creating an Account",
              ),
              backgroundColor: Color.fromARGB(255, 255, 174, 0),
            );
          });
    }
  }

  bool passconfirmed() {
    if (confirmpasscontroller.text.trim() == passcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
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
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/bgsignup.jpg"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Create an Account!",
                      style: GoogleFonts.aboreto(
                          fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please signup to continue",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFeildWidg(
                      controller: namecontroller,
                      hinttext: "Full Name of adoptioncenter/foster home",
                      Obsecuretext: false,
                      icon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 255, 174, 0),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFeildWidg(
                      controller: emailcontroller,
                      hinttext: "Email",
                      Obsecuretext: false,
                      icon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 255, 174, 0),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFeildWidg(
                        icon: Icon(
                          Icons.password,
                          color: Color.fromARGB(255, 255, 174, 0),
                        ),
                        controller: passcontroller,
                        hinttext: "Password",
                        Obsecuretext: true),
                    TextFeildWidg(
                        icon: Icon(
                          Icons.password,
                          color: Color.fromARGB(255, 255, 174, 0),
                        ),
                        controller: confirmpasscontroller,
                        hinttext: "Confirm Password",
                        Obsecuretext: true),
                    SizedBox(
                      height: 10,
                    ),
                    // Add a dropdown to select user type
                    DropdownButtonFormField<String>(
                      value: _userType,
                      onChanged: (String? value) {
                        setState(() {
                          _userType = value;
                        });
                      },
                      items: <String>['Adoption Center', 'Foster Home']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Select User Type',
                        icon: Icon(
                          Icons.category,
                          color: Color.fromARGB(255, 255, 174, 0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Buttonsubmit(Textt: "Sign up", onTap: signup),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account",
                          style: GoogleFonts.oswald(),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        GestureDetector(
                          onTap: widget.showloginpage,
                          child: Text(
                            "Login",
                            style: GoogleFonts.oswald(color: Colors.blue),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
