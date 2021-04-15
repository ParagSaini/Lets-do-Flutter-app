import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog {
  BuildContext context;
  ColorPickerDialog({this.context});

  Future<Color> showColorPickerDialog({String message, Color currentColor}) {
    Color pickerColor = currentColor;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//        backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            title: Text(
              message,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: (Color color) {
                  pickerColor = color;
                },
                showLabel: true,
                enableAlpha: false,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Got it',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(pickerColor);
                },
              ),
            ],
          );
        });
  }
}
