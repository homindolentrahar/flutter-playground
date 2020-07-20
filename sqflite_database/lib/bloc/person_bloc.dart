import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sqflite_database/bloc/person_event.dart';
import 'package:sqflite_database/bloc/person_state.dart';
import 'package:sqflite_database/database/database_helper.dart';
import 'package:sqflite_database/model/person.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final CRUD _crud = CRUD();

  PersonBloc() : super(PersonInitial());

  void getAllPersons() {
    add(GetAllPersons());
  }

  void addPerson(Person person) {
    add(AddPerson(person: person));
  }

  void updatePerson(Person person) {
    add(UpdatePerson(person: person));
  }

  void deletePerson(Person person) {
    add(DeletePerson(person: person));
  }

  @override
  Stream<PersonState> mapEventToState(
    PersonEvent event,
  ) async* {
    if (event is GetAllPersons) {
      yield PersonLoaded(persons: await _crud.getPersons());
    } else if (event is AddPerson) {
      await _crud.insert(event.person);
      yield (PersonLoaded(persons: await _crud.getPersons()));
    } else if (event is UpdatePerson) {
      await _crud.update(event.person);
      yield (PersonLoaded(persons: await _crud.getPersons()));
    } else if (event is DeletePerson) {
      await _crud.delete(event.person);
      yield (PersonLoaded(persons: await _crud.getPersons()));
    }
  }
}
