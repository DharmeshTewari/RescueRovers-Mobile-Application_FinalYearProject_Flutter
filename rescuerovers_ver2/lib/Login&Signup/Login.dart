import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rescuerovers/BottomNavBar.dart';
import 'package:rescuerovers/Bottomforfoster.dart';
import 'ReqWidgets.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.showregisterpage});
  final VoidCallback showregisterpage;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  Future signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passcontroller.text.trim());
      // After successful login, you can check the user type and navigate accordingly
      // if (_userType == 'Adoption Center') {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => BottomForFosters()),
      //   );
      //   // Navigate to Adoption Center dashboard
      // } else if (_userType == 'Foster Home') {
      //   // Navigate to Foster Home dashboard
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => BottomNavbarrr()),
      //   );
      // }
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Wrong Credential",
              ),
              backgroundColor: Color.fromARGB(255, 255, 174, 0),
            );
          });
    }
  }

  final _formKey = GlobalKey<FormState>();
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
                      child: Image.asset("assets/bgsignin.jpg"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Welcome!!!",
                      style: GoogleFonts.aboreto(
                          fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please Sign in to continue",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Add a dropdown to select user type
                    // DropdownButtonFormField<String>(
                    //   value: _userType,
                    //   onChanged: (String? value) {
                    //     setState(() {
                    //       _userType = value;
                    //     });
                    //   },
                    //   items: <String>['Adoption Center', 'Foster Home']
                    //       .map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   decoration: InputDecoration(
                    //     labelText: 'Select User Type',
                    //     icon: Icon(
                    //       Icons.category,
                    //       color: Color.fromARGB(255, 255, 174, 0),
                    //     ),
                    //   ),
                    // ),
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
                    SizedBox(
                      height: 10,
                    ),
                    Buttonsubmit(Textt: "Login", onTap: signin),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dosen't have an account?",
                          style: GoogleFonts.oswald(),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        InkWell(
                          onTap: widget.showregisterpage,
                          child: Text(
                            "Create One",
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
