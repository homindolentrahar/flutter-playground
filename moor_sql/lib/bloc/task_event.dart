import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moor_sql/database/moor_database.dart';

@immutable
abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => const [];
}

class GetAllTasks extends TaskEvent {}

class GetCompletedTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TasksCompanion tasksCompanion;
  final bool completed;

  AddTask({this.tasksCompanion, this.completed});

  @override
  List<Object> get props => [tasksCompanion, completed];
}

class UpdateTask extends TaskEvent {
  final TasksCompanion tasksCompanion;
  final bool completed;

  UpdateTask({this.tasksCompanion, this.completed});

  @override
  List<Object> get props => [tasksCompanion, completed];
}

class DeleteTask extends TaskEvent {
  final TasksCompanion tasksCompanion;
  final bool completed;

  DeleteTask({this.tasksCompanion, this.completed});

  @override
  List<Object> get props => [tasksCompanion, completed];
}
