import 'package:flutter/material.dart';
import 'package:sqflite_database/model/person.dart';

@immutable
abstract class PersonEvent {}

class GetAllPersons extends PersonEvent {}

class AddPerson extends PersonEvent {
  final Person person;

  AddPerson({this.person});
}

class UpdatePerson extends PersonEvent {
  final Person person;

  UpdatePerson({this.person});
}

class DeletePerson extends PersonEvent {
  final Person person;

  DeletePerson({this.person});
}
