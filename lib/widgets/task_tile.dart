import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsdo/AlertDialogs/delete_alert_dialog.dart';
import 'package:letsdo/main.dart';
import 'package:letsdo/models/settings.dart';
import 'package:provider/provider.dart';
import 'package:letsdo/AlertDialogs/rename_alert_dialog.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
    this.name,
    this.checkBoxState,
    this.checkboxCallback,
    this.toDeleteCallback,
    this.toRenameCallback,
  });

  final Function toDeleteCallback;
  final String name;
  final bool checkBoxState;
  final Function checkboxCallback;
  final Function toRenameCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0.0),
      dense: Provider.of<Settings>(context).isDense,
      onLongPress: () async {
        localVibration.vibrate();
        bool deleteConfirmation =
            await DeleteDialog(context: context).showAlertDialog(
                message: 'Do you want to delete this task ?',
                icon: Icons.delete_outline,
//                colour: Colors.white,
                onYesPressed: () {
                  Navigator.pop(context, true);
                },
                onNoPressed: () {
                  Navigator.pop(context, false);
                });
        if (deleteConfirmation == true) {
          toDeleteCallback();
        }
      },
      leading: !checkBoxState
          ? RawMaterialButton(
              constraints: BoxConstraints(),
              child: Icon(
                Icons.edit,
                color: Provider.of<Settings>(context).secondaryColorIsLight
                    ? Colors.grey.shade800
                    : Colors.white,
              ),
              onPressed: () async {
                print('button pressed');
                await RenameAlertDialog(context: context).showAlertDialog(
                    message: 'Rename this Task',
                    oldName: name,
                    getNewName: toRenameCallback);
              },
            )
          : RawMaterialButton(
              constraints: BoxConstraints(),
              onPressed: () {},
            ),
      title: Text(
        name,
        style: TextStyle(
          decoration: checkBoxState ? TextDecoration.lineThrough : null,
          fontSize: 20.0,
          color: Provider.of<Settings>(context).secondaryColorIsLight
              ? Colors.black87
              : Colors.white,
        ),
      ),
      trailing: Theme(
        data: ThemeData(
          unselectedWidgetColor:
              Provider.of<Settings>(context).secondaryColorIsLight
                  ? Colors.black87
                  : Colors.white,
        ),
        child: Checkbox(
          value: checkBoxState,
          activeColor: Provider.of<Settings>(context).currentPrimaryColor,
          onChanged: (value) {
            checkboxCallback(value);
          },
        ),
      ),
    );
  }
}
