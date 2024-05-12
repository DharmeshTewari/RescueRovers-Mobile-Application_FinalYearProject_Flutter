import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rescuerovers/fosterhomes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Login&Signup/ReqWidgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class DogDetails extends StatefulWidget {
  DogDetails(
      {super.key,
      required this.dogAge,
      required this.dogBreed,
      required this.dogName,
      required this.dogCityLocation,
      required this.imgUrl,
      required this.dogdiscription,
      required this.fosterhomesphonenumber,
      required this.Fosterhomesemail});
  final String dogAge;
  final String dogBreed;
  final String dogName;
  final String dogCityLocation;
  final String imgUrl;
  final String dogdiscription;
  final String fosterhomesphonenumber;
  final String Fosterhomesemail;

  @override
  State<DogDetails> createState() => _DogDetailsState();
}

class _DogDetailsState extends State<DogDetails> {
  void _sendadoptionemail() async {
    Uri uri = Uri.parse(
        "mailto:${widget.Fosterhomesemail}?subject=I want to adopt your ${widget.dogName}.Please contact me");
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      AlertDialog(
        title: Text("Error"),
        content: Text("An error occurred."),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    }
  }

  void _launchwhatsapp() async {
    String message = 'Hello,I Want Your Dog';
    final url = Uri.parse(
        'https://wa.me/${widget.fosterhomesphonenumber}?text=${Uri.encodeFull(message)}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      AlertDialog(
        title: Text("Error"),
        content: Text("An error occurred while contacting on WhatsApp."),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.dogName,
          style: GoogleFonts.oswald(),
        )),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height) / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    widget.imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              widget.dogName,
              style: GoogleFonts.aboreto(
                  fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: (MediaQuery.of(context).size.width) / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dog Age",
                            style: GoogleFonts.oswald(),
                          ),
                          Text(
                            ("${widget.dogAge} years"),
                            style: GoogleFonts.oswald(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: (MediaQuery.of(context).size.width) / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dog Breed",
                            style: GoogleFonts.oswald(),
                          ),
                          Text(
                            widget.dogBreed,
                            style: GoogleFonts.oswald(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Description",
              style: GoogleFonts.aboreto(
                  fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.dogdiscription,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Contact details",
                    style: GoogleFonts.aboreto(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Location:",
                    style: GoogleFonts.aboreto(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.location_on),
                  Text(
                    widget.dogCityLocation,
                    style: GoogleFonts.aboreto(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 174, 0)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number:",
                    style: GoogleFonts.aboreto(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.fosterhomesphonenumber,
                    style: GoogleFonts.aboreto(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Buttonsubmit(Textt: "Adopt Now", onTap: _sendadoptionemail),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: _launchwhatsapp,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 39, 39, 39)),
                  height: 50,
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/whatsapp.png",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Contact On WhatsApp",
                        style: GoogleFonts.abel(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
