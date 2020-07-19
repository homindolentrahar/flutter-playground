import 'package:moor_flutter/moor_flutter.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get color => integer()();

  TextColumn get task => text()();

  DateTimeColumn get date => dateTime()();

  BoolColumn get completed => boolean().withDefault(Constant(false))();
}
