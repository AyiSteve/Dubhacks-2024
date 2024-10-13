
import 'package:dubhack_24/heart.dart';
import 'package:dubhack_24/upload.dart';
import 'package:flutter/material.dart';
import 'homepage.dart'; 

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPlace = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFE6EAE4),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home),
            ],
          ),
        ),
        body: Center(
          child: _getBody(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.heart_broken), label: 'Heart'),

          ],
          backgroundColor: const Color(0xFFE6EAE4),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentPlace,
          onTap: (int index) {
            setState(() {
              currentPlace = index;
            });
          },
        ),
      ),
    );
  }

  Widget _getBody() {
    return [
      HomePage(),  
      UploadPage(), 
      FoodSafetyPage(),
    ][currentPlace];
  }
}
