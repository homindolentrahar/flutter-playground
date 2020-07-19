import 'package:flutter/material.dart';
import 'package:sqflite_database/model/person.dart';

@immutable
abstract class PersonState {}

class PersonInitial extends PersonState {}

class PersonLoaded extends PersonState {
  final List<Person> persons;

  PersonLoaded({this.persons});
}

class PersonError extends PersonState {
  final String error;

  PersonError({this.error});
}
