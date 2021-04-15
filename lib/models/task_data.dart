import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'; // or we can use material.dart also
import 'package:letsdo/models/files_handling.dart';
import 'package:letsdo/models/task.dart';
import 'dart:io';
import 'dart:convert';

class TaskPerPage {
  List<Task> taskList = [];
  String taskCategory = 'My Tasks';
}

class TaskData extends ChangeNotifier {
  List<TaskPerPage> _taskListPerPage = [];
  List<int> _remainingTask = [];
  int _currentPage = 0;

  UnmodifiableListView taskListOnPageNo(int pageNo) {
    return UnmodifiableListView(_taskListPerPage[pageNo].taskList);
  }

  String get taskCategoryCurrentPage {
    return _taskListPerPage[_currentPage].taskCategory;
  }

  String taskCategoryPageNo(int pageNo) {
    return _taskListPerPage[pageNo].taskCategory;
  }

  void updateCurrentPage(int updatePage) {
    _currentPage = updatePage;
    notifyListeners();
  }

  int get taskPageCount {
    return _taskListPerPage.length;
  }

  int get taskCountOnCurrentPage {
    return _taskListPerPage[_currentPage].taskList.length;
  }

  int taskCountOnPageNo(int pageNo) {
    return _taskListPerPage[pageNo].taskList.length;
  }

  int get remainingTaskOnCurrentPage {
    return _remainingTask[_currentPage];
  }

  Future<void> getLocalDataAndSettings() async {
    Files file = Files();
    await file.getLocalData();
    makeInitialTaskList();
  }

  void makeInitialTaskList() {
    try {
      /// decoding a null, gives us a runtime error, therefore don't use jsonDecode(jsonFile.readAsStringSync()), if jsonFile.readAsStringSync() is null.
      File jsonFileContent =
          Files.jsonFileContent; // creating reference of Files.jsonFileContent

      if (jsonFileContent.readAsStringSync().isNotEmpty) {
        Map<String, dynamic> fileContentMap =
            jsonDecode(jsonFileContent.readAsStringSync());

        /// json decode return map of type <string, dynamic>

        for (var Category in fileContentMap.keys) {
          TaskPerPage taskPerPage = TaskPerPage();
          taskPerPage.taskCategory = Category;
          _remainingTask.add(0);

          for (var TaskName in fileContentMap[Category].keys) {
            String taskName = TaskName.toString();
            bool isDone = fileContentMap[Category][TaskName];
            if (!isDone) {
              _remainingTask.last++;
            }
            Task task = Task(name: taskName, isDone: isDone);
            taskPerPage.taskList.add(task);
          }
          _taskListPerPage.add(taskPerPage);
        }

        /// this is important because we are actually showing the view in reverse direction
        _currentPage = _taskListPerPage.length - 1;
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteTask(Task task) {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonFileContent.readAsStringSync());
    String taskName = task.name;
    bool isDone = task.isDone;
    temp[_taskListPerPage[_currentPage].taskCategory].remove(taskName);
    Files.jsonFileContent.writeAsStringSync(jsonEncode(temp));
    _taskListPerPage[_currentPage].taskList.remove(task);
    if (!isDone) {
      _remainingTask[_currentPage]--;
    }
    notifyListeners();
  }

  void addTask(String newTask) {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonFileContent.readAsStringSync());
    temp[_taskListPerPage[_currentPage].taskCategory][newTask] =
        false; // adding new key value to our map
    Files.jsonFileContent.writeAsStringSync(jsonEncode(temp));
    _taskListPerPage[_currentPage].taskList.add(Task(name: newTask));
    _remainingTask[_currentPage]++;
    notifyListeners();
  }

  void updateTaskStatus(Task task) {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonFileContent.readAsStringSync());
    bool checkboxState = task.isDone;
    temp[_taskListPerPage[_currentPage].taskCategory][task.name] =
        !temp[_taskListPerPage[_currentPage].taskCategory][task.name];
    Files.jsonFileContent.writeAsStringSync(jsonEncode(temp));
    if (checkboxState) {
      _remainingTask[_currentPage]++;
    } else {
      _remainingTask[_currentPage]--;
    }
    task.toggleDone();
    notifyListeners();
  }

  void updateTaskName(Task task, String newName) {
    addTask(newName);
    deleteTask(task);
    notifyListeners();
  }

  // the category name is already checked that it is not present in our current map
  void addNewCategory(String categoryName) {
    TaskPerPage taskPerPage = TaskPerPage();
    taskPerPage.taskCategory = categoryName;
    taskPerPage.taskList = [];

    _taskListPerPage.add(taskPerPage);
    _remainingTask.add(0);
    _currentPage++;

    Map<String, dynamic> temp =
        jsonDecode(Files.jsonFileContent.readAsStringSync());
    temp[categoryName] = {};
    Files.jsonFileContent.writeAsStringSync(jsonEncode(temp));

    notifyListeners();
  }

  void deleteCategory() {
    String removeCategory = _taskListPerPage[_currentPage].taskCategory;
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonFileContent.readAsStringSync());

    temp.remove(removeCategory);

    _taskListPerPage.removeAt(_currentPage);
    _remainingTask.removeAt(_currentPage);

    if (temp.isEmpty) {
      _remainingTask.add(0);
      TaskPerPage taskPerPage = TaskPerPage();
      _taskListPerPage.add(taskPerPage);
      temp[taskPerPage.taskCategory] = {};
      Files.jsonFileContent.writeAsStringSync(jsonEncode(temp));
      _currentPage = 0;

      notifyListeners();

      return;
    }

    Files.jsonFileContent.writeAsStringSync(jsonEncode(temp));

    if (_currentPage != 0) {
      _currentPage--;
    }

    notifyListeners();
  }
}
