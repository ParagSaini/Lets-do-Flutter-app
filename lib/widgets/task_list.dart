import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:letsdo/AlertDialogs/delete_alert_dialog.dart';
import 'package:letsdo/main.dart';
import 'package:letsdo/models/settings.dart';
import 'package:letsdo/models/task_data.dart';
import 'package:letsdo/widgets/task_tile.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  TaskList({this.pageNo});
  final int pageNo;
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  color: Colors.transparent,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Text(
                          taskData.taskCategoryPageNo(pageNo),
                          style: TextStyle(
                            color: Provider.of<Settings>(context)
                                    .secondaryColorIsLight
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onLongPress: () async {
                  localVibration.vibrate();
                  bool deleteConfirmation =
                      await DeleteDialog(context: context).showAlertDialog(
                    message: 'Do you really want to delete this category',
//                  colour: Colors.white,
                    icon: Icons.delete_forever,
                    onYesPressed: () {
                      Navigator.pop(context, true);
                    },
                    onNoPressed: () {
                      Navigator.pop(context, false);
                    },
                  );
                  if (deleteConfirmation == true) {
                    Provider.of<TaskData>(context, listen: false)
                        .deleteCategory();
                  }
                },
              ),
              Expanded(
                child: ListView.builder(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 60.0),
                  itemCount: taskData.taskCountOnPageNo(pageNo),
                  itemBuilder: (context, curIndex) {
                    // for getting the recent task come on top of our task list, and new task to come on top
                    final index =
                        taskData.taskCountOnPageNo(pageNo) - 1 - curIndex;
                    final task = taskData.taskListOnPageNo(pageNo)[index];
                    return TaskTile(
                        name: task.name,
                        checkBoxState: task.isDone,
                        checkboxCallback: (isChecked) {
                          taskData.updateTaskStatus(task);
                        },
                        toDeleteCallback: () {
                          print('done');
                          taskData.deleteTask(task);
                        },
                        toRenameCallback: (String newName) {
                          // if this name is same as previous do nothing.
                          if (task.name != newName) {
                            print('removing in progress');
                            taskData.updateTaskName(task, newName);
                          }
                        });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
