import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:letsdo/models/files_handling.dart';
import 'package:letsdo/models/settings.dart';
import 'package:letsdo/models/task_data.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTask;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Provider.of<Settings>(context).currentSecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(17.0),
            topRight: Radius.circular(17.0),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Provider.of<Settings>(context).currentPrimaryColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextField(
                autofocus: true,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Provider.of<Settings>(context).secondaryColorIsLight
                      ? Colors.black
                      : Colors.white,
                ),
                cursorColor:
                    Provider.of<Settings>(context).secondaryColorIsLight
                        ? Colors.black
                        : Colors.white,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  newTask = value;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                height: 50.0,
                color: Provider.of<Settings>(context).currentPrimaryColor,
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 20.0,
//                color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {
                  // to eliminate leading and trailing whitespaces
                  if (newTask != null && newTask.trim().isNotEmpty) {
                    newTask = newTask.trim();
                    Map<String, dynamic> temp =
                        jsonDecode(Files.jsonFileContent.readAsStringSync());
                    String category =
                        Provider.of<TaskData>(context, listen: false)
                            .taskCategoryCurrentPage;
                    if (temp[category][newTask] != null) {
                      Fluttertoast.showToast(
                        msg: 'Task with same name already Exist',
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else {
                      Provider.of<TaskData>(context, listen: false)
                          .addTask(newTask);
                      Navigator.pop(context);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
