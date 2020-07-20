import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moor_sql/database/moor_database.dart';

@immutable
abstract class TaskState extends Equatable {
  @override
  List<Object> get props => const [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskCompleted extends TaskState {
  final List<Task> tasks;

  TaskCompleted({this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskFailure extends TaskState {
  final String error;

  TaskFailure({this.error});

  @override
  List<Object> get props => [error];
}
