import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  late SharedPreferences _prefs;
  late List<String> _favoriteDogNames = [];

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteDogNames = _prefs
          .getKeys()
          .where((key) => _prefs.getBool(key) ?? false)
          .toList();
    });
  }

  Future<void> removeFromFavorites(String dogName) async {
    setState(() {
      _favoriteDogNames.remove(dogName);
      _prefs.remove(dogName); // Remove from SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Favourite Dogs'),
      ),
      body: _favoriteDogNames.isEmpty
          ? Center(
              child: Text('No favorite dogs yet'),
            )
          : ListView.builder(
              itemCount: _favoriteDogNames.length,
              itemBuilder: (context, index) {
                final dogName = _favoriteDogNames[index];
                return ListTile(
                  tileColor: Colors.grey[200],
                  title: Text(
                    "Dogname : ${dogName}",
                    style: GoogleFonts.oswald(fontSize: 20),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      removeFromFavorites(dogName);
                    },
                  ),
                  // You can add more details or actions here if needed
                );
              },
            ),
    );
  }
}
