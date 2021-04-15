import 'package:vibration/vibration.dart';

class LocalVibration {
  bool haveVibration = false;
  Future<void> checkSupport() async {
    try {
      if (await Vibration.hasVibrator())
        haveVibration = await Vibration.hasCustomVibrationsSupport();
    } catch (e) {
      print(e);
    }
  }

  void vibrate() {
    try {
      if (haveVibration) Vibration.vibrate(duration: 30);
    } catch (e) {
      print(e);
    }
  }
}
