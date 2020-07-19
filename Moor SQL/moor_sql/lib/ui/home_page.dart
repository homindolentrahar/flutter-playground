import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:moor_sql/bloc/task_bloc.dart';
import 'package:moor_sql/bloc/task_state.dart';
import 'package:moor_sql/database/moor_database.dart';
import 'package:moor_sql/ui/add_new_task.dart';
import 'package:moor_sql/util/injection.dart';

class HomePage extends StatefulWidget {
  static const String TYPE_ADD = "type_add";
  static const String TYPE_UPDATE = "type_update";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TaskBloc _bloc;
  bool _completed;

  @override
  void initState() {
    _bloc = locator.get<TaskBloc>(instanceName: "bloc");
    _completed = false;
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _showBottomSheet(Task task, Function addUpdate) {
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
        child: AddNewTask(
          task: task,
          addTask: _addTask,
          updateTask: _updateTask,
        ),
      ),
    );
  }

  void _addTask(Color color, String name, DateTime date, bool completed) {
    if (color == null || name == null || date == null || completed == null) {
      return;
    }

    final task = TasksCompanion(
      color: moor.Value(color.value),
      task: moor.Value(name),
      date: moor.Value(date),
      completed: moor.Value(completed),
    );

    _bloc.addTask(task, _completed);

    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  void _updateTask(Task task) {
    _bloc.updateTask(task.toCompanion(false), _completed);

    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_completed) {
      _bloc.getCompletedTasks();
    } else {
      _bloc.getAllTasks();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: -10,
          leading: Icon(
            Icons.content_paste,
            color: Colors.black54,
          ),
          title: Text(
            "Tasoku",
            style: GoogleFonts.quicksand(
              color: Colors.black54,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Completed",
                  style: GoogleFonts.quicksand(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Switch(
                  value: _completed,
                  onChanged: (value) {
                    setState(() {
                      _completed = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          bloc: _bloc,
          builder: (ctx, state) {
            if (state is TaskLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TaskCompleted) {
              final tasks = state.tasks;

              return ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: tasks.length,
                itemBuilder: (ctx, index) {
                  final task = tasks[index];

                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          _bloc.deleteTask(task.toCompanion(false), _completed);
                        },
                      ),
                    ],
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(task.color),
                      ),
                      title: Text(
                        task.task,
                        style: GoogleFonts.quicksand(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(task.date),
                        style: GoogleFonts.quicksand(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Checkbox(
                        value: task.completed,
                        onChanged: (value) {
                          _bloc.updateTask(
                              task
                                  .copyWith(completed: value)
                                  .toCompanion(false),
                              _completed);
                        },
                      ),
                      onTap: () => _showBottomSheet(task, _addTask),
                    ),
                  );
                },
              );
            } else if (state is TaskFailure) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.black54,
                    size: 48,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "You have no task !",
                    style: GoogleFonts.quicksand(
                      color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: Text(
            "Add Task",
            style: GoogleFonts.quicksand(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onPressed: () => _showBottomSheet(null, _addTask),
        ),
      ),
    );
  }
}
