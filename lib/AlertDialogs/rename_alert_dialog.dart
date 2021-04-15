import 'package:flutter/material.dart';

class RenameAlertDialog {
  BuildContext context;
  RenameAlertDialog({this.context});

  Future<bool> showAlertDialog(
      {String message, String oldName, Function getNewName}) {
    TextEditingController _controller = TextEditingController(text: oldName);
    String newName = oldName;
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
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
                  message,
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
                        controller: _controller,
                        style: TextStyle(fontSize: 20.0),
                        autofocus: true,
                        onChanged: (newValue) {
                          newName = newValue;
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
                        if (newName.trim().isNotEmpty) {
                          getNewName(newName.trim());
                        }
                        Navigator.pop(context);
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
