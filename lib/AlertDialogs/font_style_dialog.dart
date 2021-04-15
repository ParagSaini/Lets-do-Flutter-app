import 'dart:collection';
import 'package:letsdo/models/font_families.dart';
import 'package:letsdo/models/settings.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FontStyleDialog {
  BuildContext context;
  FontStyleDialog({this.context});

  Future<bool> showAlertDialog() {
    UnmodifiableListView<String> fontFamilyList = FontFamily().fontFamilyList;
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
            child: ListView.builder(
                itemCount: fontFamilyList.length,
                itemBuilder: (context, index) {
                  String curFontFamily = fontFamilyList[index];
                  return ListTile(
                    leading: Text(
                      curFontFamily,
                      style: TextStyle(
                        fontFamily: curFontFamily,
                        fontSize: 22.0,
                      ),
                    ),
                    onTap: () {
                      Provider.of<Settings>(context, listen: false)
                          .changeFontFamily(curFontFamily);
                      Navigator.pop(context);
                    },
                  );
                }),
          ),
        );
      },
    );
  }
}
