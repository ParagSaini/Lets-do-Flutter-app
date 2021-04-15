import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:letsdo/AlertDialogs/color_picker.dart';
import 'package:letsdo/AlertDialogs/delete_alert_dialog.dart';
import 'package:letsdo/AlertDialogs/font_style_dialog.dart';
import 'package:letsdo/AlertDialogs/theme_mode_alert_dialog.dart';
import 'package:letsdo/models/settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: Provider.of<Settings>(context).currentPrimaryColor,
        elevation: 8.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              dense: true,
              leading: Text(
                'Theme Mode',
                style: TextStyle(
//                color: Colors.grey.shade700,
                  fontSize: 20.0,
                ),
              ),
              trailing: CircleAvatar(
                radius: 13.0,
                backgroundColor: Provider.of<Settings>(context).isDarkTheme
                    ? Colors.grey[900]
                    : Colors.grey[200],
              ),
              onTap: () {
                bool currentThemeIsDark =
                    Provider.of<Settings>(context, listen: false).isDarkTheme;
                ThemeModeDialog(context: context).showAlertDialog(
                    onPressed: (bool isDark) {
                  if (isDark != currentThemeIsDark) {
                    Provider.of<Settings>(context, listen: false)
                        .changeThemeMode(isDark);
                  }
                });
              },
            ),
            Divider(
              height: 0.0,
            ),
            ListTile(
              dense: true,
              leading: Text(
                'Primary Color',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: CircleAvatar(
                radius: 13.0,
                backgroundColor:
                    Provider.of<Settings>(context).currentPrimaryColor,
              ),
              onTap: () async {
                Color pickedColor = await ColorPickerDialog(context: context)
                    .showColorPickerDialog(
                  message: 'Pick a Color!',
                  currentColor: Provider.of<Settings>(context, listen: false)
                      .currentPrimaryColor,
                );
                if (pickedColor != null) {
                  print(pickedColor);
                  Provider.of<Settings>(context, listen: false)
                      .changePrimaryColor(pickedColor);
                }
              },
            ),
            Divider(
              height: 0.0,
            ),
            ListTile(
              dense: true,
              leading: Text(
                'Secondary Color',
                style: TextStyle(fontSize: 20.0),
              ),
              trailing: CircleAvatar(
                radius: 13.0,
                backgroundColor:
                    Provider.of<Settings>(context).currentSecondaryColor,
              ),
              onTap: () async {
                Color pickedColor = await ColorPickerDialog(context: context)
                    .showColorPickerDialog(
                  message: 'Pick a Color!',
                  currentColor: Provider.of<Settings>(context, listen: false)
                      .currentSecondaryColor,
                );
                if (pickedColor != null) {
                  print(pickedColor);
                  Provider.of<Settings>(context, listen: false)
                      .changeSecondaryColor(pickedColor);
                }
              },
            ),
            Divider(
              height: 0.0,
            ),
            ListTile(
              leading: Text(
                'Font Styles',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () {
                FontStyleDialog(context: context).showAlertDialog();
              },
            ),
            Divider(
              height: 0.0,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 15.0, right: 5.0),
              dense: true,
              leading: Text(
                'Dense View',
                style: TextStyle(
//                color: Colors.grey.shade700,
                  fontSize: 20.0,
                ),
              ),
              trailing: Checkbox(
                activeColor: Provider.of<Settings>(context).currentPrimaryColor,
                value: Provider.of<Settings>(context).isDense,
                onChanged: (value) {
                  Provider.of<Settings>(context, listen: false).toggleDense();
                },
              ),
            ),
            Divider(
              height: 0.0,
            ),
            ListTile(
              dense: true,
              leading: Text(
                'Restore to defaults',
                style: TextStyle(fontSize: 20.0),
              ),
              onTap: () async {
                bool toRestore =
                    await DeleteDialog(context: context).showAlertDialog(
                  message: 'This will restore the Settings to default.',
//                  colour: Colors.white,
                  icon: Icons.restore,
                  onNoPressed: () {
                    Navigator.pop(context, false);
                  },
                  onYesPressed: () {
                    Navigator.pop(context, true);
                  },
                );
                if (toRestore == true) {
                  // todo : restore the settings
                  Provider.of<Settings>(context, listen: false)
                      .restoreDefault();
                }
              },
            ),
            Divider(
              height: 0.0,
            ),
            ListTile(
              leading: Text(
                'Icon Credit',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onTap: () async {
                const url = "https://icons8.com";
                try {
                  bool proceed = await canLaunch(url);
                  if (proceed)
                    await launch(url);
                  else
                    Fluttertoast.showToast(msg: "can't launch url. Try again");
                } catch (e) {
                  print(e);
                }
              },
            ),
            Divider(
              height: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}
