import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:letsdo/models/files_handling.dart';

class NewCategoryAlertDialog {
  BuildContext context;
  NewCategoryAlertDialog({this.context});

  Future<bool> showAlertDialog(Function getNewName) {
    String categoryName = '';
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
//          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Add New Category',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22.0,
//                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      size: 25.0,
//                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Flexible(
                      child: TextField(
//                        controller: _controller,
                        autofocus: true,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        onChanged: (newValue) {
                          categoryName = newValue;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'CONFIRM',
                        style: TextStyle(
//                          color: Color(0xff01579b),
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        // trim eliminates the leading and trailing whitespaces
                        if (categoryName != null &&
                            categoryName.trim().isNotEmpty) {
                          categoryName = categoryName.trim();

                          Map<String, dynamic> temp = jsonDecode(
                              Files.jsonFileContent.readAsStringSync());
                          if (temp.containsKey(categoryName)) {
                            Fluttertoast.showToast(
                              msg: 'Category with same name already Exist',
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          } else {
                            getNewName(categoryName);
                            Navigator.pop(context, true);
                          }
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
