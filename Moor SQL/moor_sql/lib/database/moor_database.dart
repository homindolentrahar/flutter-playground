import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_sql/model/tables.dart';

part 'moor_database.g.dart';

@UseMoor(tables: [Tasks], daos: [TaskDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          FlutterQueryExecutor(
              path: "db.sqlite", logStatements: true, singleInstance: true),
        );

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(AppDatabase database) : super(database);

  Future<List<Task>> getAllTasks() {
    return (select(tasks)
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.date, mode: OrderingMode.desc),
            (table) => OrderingTerm(expression: table.task),
          ]))
        .get();
  }

  Future<List<Task>> getCompletedTasks() {
    return (select(tasks)
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.date, mode: OrderingMode.desc),
            (table) => OrderingTerm(expression: table.task),
          ])
          ..where(
            (table) => table.completed.equals(true),
          ))
        .get();
  }

  Future addTask(Insertable<Task> task) {
    return into(tasks).insert(task);
  }

  Future updateTask(Insertable<Task> task) {
    return update(tasks).replace(task);
  }

  Future deleteTask(Insertable<Task> task) {
    return delete(tasks).delete(task);
  }
}
