import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsdo/double_press_exit.dart';
import 'package:letsdo/models/settings.dart';
import 'package:letsdo/models/task_data.dart';
import 'package:letsdo/screens/add_task_screen.dart';
import 'package:letsdo/screens/side_sheet.dart';
import 'package:letsdo/widgets/bottomContainer.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return DoublePress(exitMessage: 'Press again to exit').onWillPop();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Provider.of<Settings>(context).currentPrimaryColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Provider.of<Settings>(context).currentPrimaryColor,
          child: Icon(
            Icons.add,
            size: 35.0,
            color: Colors.white,
          ),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => AddTaskScreen(),
            );
          },
        ),
        drawer: Drawer(
          child: SideSheet(),
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 40.0, top: 20.0, bottom: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RawMaterialButton(
                        constraints: BoxConstraints(),
                        child: CircleAvatar(
                          child: Icon(
                            Icons.list,
                            color: Provider.of<Settings>(context)
                                .currentPrimaryColor,
                            size: 30.0,
                          ),
                          radius: 28.0,
                          backgroundColor: Provider.of<Settings>(context)
                              .currentSecondaryColor,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Let\'s do',
                        style: TextStyle(
//                        fontFamily: 'Slabo27px',
                          fontSize: 50.0,
//                        color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '${Provider.of<TaskData>(context).taskCountOnCurrentPage} Tasks',
                            style: TextStyle(
//                            color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${Provider.of<TaskData>(context).remainingTaskOnCurrentPage} Todo',
                            style: TextStyle(
//                            color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: BottomContainer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
