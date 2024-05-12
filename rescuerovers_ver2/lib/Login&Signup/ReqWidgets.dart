import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFeildWidg extends StatelessWidget {
  TextFeildWidg({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.Obsecuretext,
    required this.icon,
  });
  TextEditingController controller;
  String hinttext;
  Icon icon;
  bool Obsecuretext;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            style: GoogleFonts.oswald(),
            obscureText: Obsecuretext,
            controller: controller,
            decoration: InputDecoration(
              icon: icon,
              hintText: hinttext,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class Buttonsubmit extends StatelessWidget {
  Buttonsubmit({super.key, required this.Textt, required this.onTap});
  final String Textt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 255, 174, 0),
            ),
            child: Center(
              child: Text(
                Textt,
                style: GoogleFonts.oswald(
                    color: const Color.fromARGB(221, 255, 255, 255),
                    fontSize: 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
