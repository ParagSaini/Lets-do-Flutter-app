import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class Files {
  Directory _dir;
  static File jsonFileContent; // reference of the file
  static File jsonSettingFile;
  String _taskFileName = "tasks.json";
  String _settingFileName = "settings.json";
  bool _taskFileExists = false;
  bool _settingFileExists = false;

  Future<void> getLocalData() async {
    _dir = await getApplicationDocumentsDirectory();
    jsonFileContent = File(_dir.path +
        '/' +
        _taskFileName); // setting the reference of tasks.json file into jsonFile
    jsonSettingFile = File(_dir.path + '/' + _settingFileName);

    _settingFileExists = jsonSettingFile.existsSync();
    _taskFileExists = jsonFileContent.existsSync();

    if (_taskFileExists) {
      print('existed');
    } else {
      Map<String, dynamic> taskContent = {'My Tasks': {}};
      jsonFileContent.createSync();
      // creating initially with empty maps
      jsonFileContent.writeAsStringSync(jsonEncode(taskContent));
      _taskFileExists = true;
    }

    if (_settingFileExists) {
      print('setting file existed');
    } else {
      jsonSettingFile.createSync();
      Map<String, dynamic> temp = {
        'isDense': false,
        'primaryColor': Colors.grey[900].value,
        'secondaryColor': Colors.grey[200].value,
        'isDarkTheme': true,
        'fontFamily': 'BerkshireSwash',
      }; // default settings
      jsonSettingFile.writeAsStringSync(jsonEncode(temp));
      _settingFileExists = true;
    }
    print(_dir.path);
  }
}
