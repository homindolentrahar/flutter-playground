import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moor_sql/database/moor_database.dart';

class AddNewTask extends StatefulWidget {
  final Task task;
  final Function addTask;
  final Function updateTask;

  AddNewTask({this.task, this.addTask, this.updateTask});

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController _taskController;
  Color _pickedColor;
  DateTime _pickedDate;
  bool _markCompleted;

  @override
  void initState() {
    _pickedColor = Colors.red;
    _markCompleted = false;
    _taskController = TextEditingController();

    if (widget.task != null) {
      _pickedColor = Color(widget.task.color);
      _taskController.text = widget.task.task;
      _pickedDate = widget.task.date;
      _markCompleted = widget.task.completed;
    }

    super.initState();
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          "Pick a color",
          style: GoogleFonts.quicksand(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Container(
          height: 150,
          child: MaterialColorPicker(
            circleSize: 50,
            colors: [
              Colors.red,
              Colors.blue,
              Colors.yellow,
              Colors.green,
              Colors.purple,
              Colors.orange,
              Colors.teal,
              Colors.lightBlue,
              Colors.deepPurple,
              Colors.pink,
            ],
            onColorChange: (color) {
              setState(() {
                _pickedColor = color;
              });
            },
          ),
        ),
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: _pickedDate ?? DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime.now(),
            confirmText: "Pick",
            cancelText: "Cancel")
        .then(
      (date) {
        if (date == null) {
          return;
        }

        setState(() {
          _pickedDate = date;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleColor(
                color: _pickedColor,
                elevation: 0,
                circleSize: 40,
                onColorChoose: _showColorPicker,
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                child: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: "Task Name",
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 40,
                    height: 40,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 2,
                      ),
                      highlightedBorderColor: Theme.of(context).accentColor,
                      child: Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: _showDatePicker,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    _pickedDate == null
                        ? "No Date Picked"
                        : DateFormat.yMMMd().format(_pickedDate),
                    style: GoogleFonts.quicksand(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _markCompleted,
                    onChanged: (value) {
                      setState(() {
                        _markCompleted = value;
                      });
                    },
                  ),
                  Text(
                    "Completed",
                    style: GoogleFonts.quicksand(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              ButtonTheme(
                minWidth: 90,
                height: 40,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    widget.task == null ? "Add Task" : "Update Task",
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    widget.task == null
                        ? widget.addTask(
                            _pickedColor,
                            _taskController.text,
                            _pickedDate,
                            _markCompleted,
                          )
                        : widget.updateTask(widget.task.copyWith(
                            color: _pickedColor.value,
                            completed: _markCompleted,
                            date: _pickedDate,
                            task: _taskController.text,
                          ));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
