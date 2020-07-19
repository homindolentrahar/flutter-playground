import 'package:flutter/material.dart';
import 'package:moor_sql/ui/home_page.dart';
import 'package:moor_sql/util/injection.dart';

void main() {
  setupInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moor SQL Lab',
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        accentColor: Colors.deepOrangeAccent,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
