import 'package:flutter/material.dart';

class BasicAlertDialog {
  BasicAlertDialog({this.context});
  final context;

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.lightBlueAccent,
            elevation: 10.0,
            title: Text('Do you really want to exit the App?'),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.white70,
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              FlatButton(
                color: Colors.white,
                child: Text('Yes'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }
}
