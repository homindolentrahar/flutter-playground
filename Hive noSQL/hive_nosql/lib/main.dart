import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_nosql/model/mahasiswa.dart';
import 'package:hive_nosql/ui/home_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

const String boxName = "mahasiswa";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(MahasiswaAdapter());
  await Hive.openBox<Mahasiswa>(boxName, compactionStrategy: (total, deleted) {
    return deleted > 20;
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        accentColor: Colors.deepPurpleAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
