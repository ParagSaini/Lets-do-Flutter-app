import 'package:fluttertoast/fluttertoast.dart';

class DoublePress {
  static DateTime currentBackPressTime;
  String exitMessage;

  DoublePress({this.exitMessage});

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(milliseconds: 1500)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: exitMessage);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
