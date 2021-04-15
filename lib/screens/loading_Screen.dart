import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:letsdo/models/settings.dart';
import 'package:letsdo/models/task_data.dart';
import 'package:letsdo/screens/task_screen.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDirectory();
  }

  Future<void> setDirectory() async {
    await Provider.of<TaskData>(context, listen: false)
        .getLocalDataAndSettings();

    await Provider.of<Settings>(context, listen: false).initialiseSetting();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TasksScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
