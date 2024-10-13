import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  void initState() {
    super.initState();
  }







  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFE6EAE4),
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
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
          backgroundColor: Color(0xFFE6EAE4),
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
      Icon(Icons.home),
      Icon(Icons.upload),
    ][currentPlace];
  }
}