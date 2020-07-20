import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_database/bloc/person_bloc.dart';
import 'package:sqflite_database/bloc/person_state.dart';
import 'package:sqflite_database/model/person.dart';
import 'package:sqflite_database/widget/add_update_modal.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersonBloc _bloc;

  @override
  void initState() {
    _bloc = PersonBloc();
    _bloc.getAllPersons();
    super.initState();
  }

  void _showBottomSheet(Person person) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (ctx) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: AddUpdateModal(
          person: person,
          addPerson: _addPerson,
          updatePerson: _updatePerson,
        ),
      ),
    );
  }

  void _addPerson(Person person) {
    if (person.name == null ||
        person.name == "" ||
        person.age == null ||
        person.age <= 0) {
      return;
    }

    _bloc.addPerson(person);
  }

  void _updatePerson(Person person) {
    if (person.name == "" || person.age <= 0) {
      return;
    }

    _bloc.updatePerson(person);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Sqflite Lab",
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showBottomSheet(null);
              },
            ),
          ],
        ),
        body: BlocBuilder<PersonBloc, PersonState>(
          bloc: _bloc,
          builder: (ctx, state) {
            if (state is PersonLoaded) {
              final persons = state.persons;

              return ListView.separated(
                physics: BouncingScrollPhysics(),
                separatorBuilder: (ctx, index) => Divider(),
                itemCount: persons.length,
                itemBuilder: (ctx, index) {
                  final person = persons[index];

                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      person.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      "${person.age} years old",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _bloc.deletePerson(person);
                      },
                    ),
                    onTap: () {
                      _showBottomSheet(person);
                    },
                  );
                },
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _showBottomSheet(null);
          },
        ),
      ),
    );
  }
}
