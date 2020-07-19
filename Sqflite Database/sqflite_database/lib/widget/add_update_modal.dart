import 'package:flutter/material.dart';
import 'package:sqflite_database/model/person.dart';

class AddUpdateModal extends StatefulWidget {
  final Person person;
  final Function addPerson;
  final Function updatePerson;

  AddUpdateModal({this.person, this.addPerson, this.updatePerson});

  @override
  _AddUpdateModalState createState() => _AddUpdateModalState();
}

class _AddUpdateModalState extends State<AddUpdateModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    if (widget.person != null) {
      _nameController.text = widget.person.name;
      _ageController.text = widget.person.age.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ButtonTheme(
              minWidth: 60,
              height: 60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: RaisedButton(
                elevation: 0,
                color: Theme.of(context).accentColor,
                child: Icon(
                  widget.person == null ? Icons.save : Icons.update,
                  color: Colors.black54,
                ),
                onPressed: () {
                  if (widget.person == null) {
                    final person = Person(
                      _nameController.text,
                      int.parse(_ageController.text),
                    );

                    widget.addPerson(person);
                  } else {
                    widget.person.name = _nameController.text;
                    widget.person.age = int.parse(_ageController.text);

                    widget.updatePerson(widget.person);
                  }

                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
