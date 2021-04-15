import 'package:flutter/material.dart';
import 'package:letsdo/AlertDialogs/new_category_alert_dialog.dart';
import 'package:letsdo/models/settings.dart';
import 'package:letsdo/models/task_data.dart';
import 'setting_screen.dart';
import 'package:provider/provider.dart';

class SideSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Provider.of<Settings>(context).currentPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 60.0, bottom: 15.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: Image.asset(
                    'images/todo.png',
                  ),
                  radius: 30.0,
                  backgroundColor:
                      Provider.of<Settings>(context).currentSecondaryColor,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'Let\'s do',
                  style: TextStyle(
//                    fontFamily: 'PermanentMarker',
                    fontSize: 40.0,
//                        color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'YOUR OWN TODO LIST APP',
              textAlign: TextAlign.center,
              style: TextStyle(
//                fontFamily: 'Chewy',
//                    color: Colors.white,
                fontSize: 25.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 50.0,
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 30.0,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ),
                );
              },
            ),
            ListTile(
                leading: Icon(
                  Icons.add_to_photos,
                  size: 30.0,
                ),
                title: Text(
                  'Add New Category',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                onTap: () async {
                  bool isSuccessful =
                      await NewCategoryAlertDialog(context: context)
                          .showAlertDialog((String categoryName) {
                    print(categoryName);
                    Provider.of<TaskData>(context, listen: false)
                        .addNewCategory(categoryName);
                  });
                  if (isSuccessful == true) {
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
