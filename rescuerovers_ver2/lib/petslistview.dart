import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DogListView extends StatefulWidget {
  DogListView(
      {Key? key,
      required this.Dogage,
      required this.Dogbreed,
      required this.Dogname,
      required this.dogcitycloaction,
      required this.imgurl})
      : super(key: key);

  final String Dogname;
  final String Dogage;
  final String dogcitycloaction;
  final String Dogbreed;
  final String imgurl;

  @override
  State<DogListView> createState() => _DogListViewState();
}

class _DogListViewState extends State<DogListView> {
  late SharedPreferences _prefs;
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = _prefs.getBool(widget.Dogname) ?? false;
    });
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      _prefs.setBool(widget.Dogname, isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.imgurl,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.Dogname,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Age: ${widget.Dogage}",
                  style: GoogleFonts.abel(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Location: ",
                      style: GoogleFonts.abel(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 255, 174, 0),
                      size: 16,
                    ),
                    Text(
                      widget.dogcitycloaction,
                      style: GoogleFonts.abel(
                        color: Color.fromARGB(255, 255, 174, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.orange : null,
                  ),
                  onPressed: toggleFavorite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
