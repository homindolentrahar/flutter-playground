import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moor_sql/bloc/task_event.dart';
import 'package:moor_sql/bloc/task_state.dart';
import 'package:moor_sql/database/moor_database.dart';
import 'package:moor_sql/util/injection.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _taskDao = locator.get<TaskDao>(instanceName: "taskDao");

  TaskBloc() : super(TaskInitial());

  void getAllTasks() {
    add(GetAllTasks());
  }

  void getCompletedTasks() {
    add(GetCompletedTasks());
  }

  void addTask(TasksCompanion tasksCompanion, bool completed) {
    add(AddTask(tasksCompanion: tasksCompanion, completed: completed));
  }

  void updateTask(TasksCompanion tasksCompanion, bool completed) {
    add(UpdateTask(tasksCompanion: tasksCompanion, completed: completed));
  }

  void deleteTask(TasksCompanion tasksCompanion, bool completed) {
    add(DeleteTask(tasksCompanion: tasksCompanion, completed: completed));
  }

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    yield TaskLoading();

    if (event is GetAllTasks) {
      yield TaskCompleted(tasks: await _taskDao.getAllTasks());
    } else if (event is GetCompletedTasks) {
      yield TaskCompleted(tasks: await _taskDao.getCompletedTasks());
    } else if (event is AddTask) {
      try {
        await _taskDao.addTask(event.tasksCompanion);
        yield TaskCompleted(
          tasks: event.completed
              ? await _taskDao.getCompletedTasks()
              : await _taskDao.getAllTasks(),
        );
      } catch (exception) {
        yield TaskFailure(
          error: exception.toString(),
        );
      }
    } else if (event is UpdateTask) {
      try {
        await _taskDao.updateTask(event.tasksCompanion);
        yield TaskCompleted(
          tasks: event.completed
              ? await _taskDao.getCompletedTasks()
              : await _taskDao.getAllTasks(),
        );
      } catch (exception) {
        yield TaskFailure(
          error: exception.toString(),
        );
      }
    } else if (event is DeleteTask) {
      try {
        await _taskDao.deleteTask(event.tasksCompanion);
        yield TaskCompleted(
          tasks: event.completed
              ? await _taskDao.getCompletedTasks()
              : await _taskDao.getAllTasks(),
        );
      } catch (exception) {
        yield TaskFailure(
          error: exception.toString(),
        );
      }
    }
  }
}
