import 'package:flutter/material.dart';

class ThemeModeDialog {
  BuildContext context;
  ThemeModeDialog({this.context});

  Future<void> showAlertDialog({Function onPressed}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
//          backgroundColor: ,
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
                  'Select a Theme Mode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22.0,
                  ),
                ),
                Divider(
                  thickness: 4.0,
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  dense: true,
                  leading: Text(
                    'Light Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 13.0,
                    backgroundColor: Colors.grey[200],
                  ),
                  onTap: () {
                    onPressed(false);
                    Navigator.pop(context);
                  },
                ),
                Divider(
                  height: 1.0,
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  dense: true,
                  leading: Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 13.0,
                    backgroundColor: Colors.black,
                  ),
                  onTap: () {
                    onPressed(true);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
