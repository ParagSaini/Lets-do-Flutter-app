import 'package:flutter/material.dart';

class DeleteDialog {
  BuildContext context;
  DeleteDialog({this.context});

  Future<bool> showAlertDialog(
      {String message,
      IconData icon,
      Function onNoPressed,
      Function onYesPressed}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
//          backgroundColor: colour,
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
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      size: 35.0,
//                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Text(
                        message,
                        style: TextStyle(
//                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'No',
                        style: TextStyle(
//                          color: Color(0xff01579b),
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        onNoPressed();
                      },
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    FlatButton(
                      child: Text(
                        'Yes',
                        style: TextStyle(
//                          color: Color(0xff01579b),
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        onYesPressed();
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
