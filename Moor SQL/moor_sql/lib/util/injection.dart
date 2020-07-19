import 'package:get_it/get_it.dart';
import 'package:moor_sql/bloc/task_bloc.dart';
import 'package:moor_sql/database/moor_database.dart';

final locator = GetIt.instance;

void setupInjection() {
  locator.registerSingleton<TaskDao>(AppDatabase().taskDao,
      instanceName: "taskDao");
  locator.registerFactory<TaskBloc>(() => TaskBloc(), instanceName: "bloc");
}
