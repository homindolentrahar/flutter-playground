import 'package:flutter/material.dart';
import 'package:sqflite_database/page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sqflite Lab",
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}
