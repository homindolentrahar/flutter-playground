import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_database/model/person.dart';

class AccessDatabase {
  Future<Database> initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + 'person.db';

    final database = openDatabase(path, version: 1, onCreate: _createDB);

    return database;
  }

  void _createDB(Database database, int version) async {
    String query = '''CREATE TABLE person 
    (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INTEGER
    )
    ''';
    await database.execute(query);
  }
}

class CRUD {
  static const table = "person";
  static const id = "id";
  static const name = "name";
  static const age = "age";

  final dbHelper = AccessDatabase();

  Future<int> insert(Person person) async {
    final database = await dbHelper.initDB();

    final result = await database.insert(
      table,
      {
        'name': person.name,
        'age': person.age,
      },
    );
    return result;
  }

  Future<int> update(Person person) async {
    final database = await dbHelper.initDB();

    final result = database.update(
      table,
      {
        'name': person.name,
        'age': person.age,
      },
      where: "$id = ?",
      whereArgs: [person.id],
    );

    return result;
  }

  Future<int> delete(Person person) async {
    final database = await dbHelper.initDB();

    final result = database.delete(
      table,
      where: "$id = ?",
      whereArgs: [person.id],
    );

    return result;
  }

  Future<List<Person>> getPersons() async {
    final database = await dbHelper.initDB();

    final result = database.query(
      table,
      columns: [id, name, age],
      orderBy: "$name ASC",
    );

    return result.then(
      (list) => list
          .map(
            (item) => Person.fromMap(item),
          )
          .toList(),
    );
  }
}
