import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsdo/models/files_handling.dart';

class Settings extends ChangeNotifier {
  bool _isDense = false;
  Color _primaryColor = Colors.grey[900];
  Color _secondaryColor = Colors.grey[200];
  bool _themeModeIsDark = true;
  bool _secondaryColorIsLight = false;
  String _fontFamily = 'Catamaran';

  Future<void> initialiseSetting() async {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonSettingFile.readAsStringSync());
    if (!temp.containsKey('primaryColor')) {
      temp['primaryColor'] = Colors.grey[900].value;
      temp['secondaryColor'] = Colors.grey[200].value;
      temp['isDarkTheme'] = true;
      temp['fontFamily'] = 'Catamaran';
      Files.jsonSettingFile.writeAsStringSync(jsonEncode(temp));
      print('in the new map creation');
    }
    _isDense = temp['isDense'];
    _primaryColor = Color(temp['primaryColor']);
    _secondaryColor = Color(temp['secondaryColor']);
    _themeModeIsDark = temp['isDarkTheme'];
    _fontFamily = temp['fontFamily'];

    setSecondaryColorIsLight();
    notifyListeners();
  }

  bool get isDarkTheme {
    return _themeModeIsDark;
  }

  bool get secondaryColorIsLight {
    return _secondaryColorIsLight;
  }

  String get fontFamily {
    return _fontFamily;
  }

  void changeFontFamily(String newFontFamily) {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonSettingFile.readAsStringSync());
    temp['fontFamily'] = newFontFamily;
    Files.jsonSettingFile.writeAsStringSync(jsonEncode(temp));

    _fontFamily = newFontFamily;
    notifyListeners();
  }

  void setSecondaryColorIsLight() {
    // Counting the perceptive luminance - human eye favors green color...
    double luminance = (0.299 * _secondaryColor.red +
            0.587 * _secondaryColor.green +
            0.114 * _secondaryColor.blue) /
        255;

    if (luminance > 0.5) {
      // bright colors - black font
      _secondaryColorIsLight = true;
    } else {
      // dark colors - white font
      _secondaryColorIsLight = false;
    }
  }

  bool get isDense {
    return _isDense;
  }

  void toggleDense() {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonSettingFile.readAsStringSync());
    temp['isDense'] = !temp['isDense'];
    Files.jsonSettingFile.writeAsStringSync(jsonEncode(temp));
    _isDense = !_isDense;
    notifyListeners();
  }

  Color get currentPrimaryColor {
    return _primaryColor;
  }

  void changePrimaryColor(Color color) {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonSettingFile.readAsStringSync());
    temp['primaryColor'] = color.value;
    Files.jsonSettingFile.writeAsStringSync(jsonEncode(temp));
    _primaryColor = color;
    notifyListeners();
  }

  Color get currentSecondaryColor {
    return _secondaryColor;
  }

  void changeSecondaryColor(Color color) {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonSettingFile.readAsStringSync());
    temp['secondaryColor'] = color.value;
    Files.jsonSettingFile.writeAsStringSync(jsonEncode(temp));
    _secondaryColor = color;
    setSecondaryColorIsLight();
    notifyListeners();
  }

  void changeThemeMode(dynamic isDark) {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonSettingFile.readAsStringSync());
    temp['isDarkTheme'] = isDark;

    _themeModeIsDark = isDark;

    if (isDark) {
      _primaryColor = Colors.grey[900];
      _secondaryColor = Colors.grey[200];
      setSecondaryColorIsLight();
      temp['primaryColor'] = _primaryColor.value;
      temp['secondaryColor'] = _secondaryColor.value;
    } else {
      _primaryColor = Colors.lightBlueAccent;
      _secondaryColor = Colors.grey[200];
      setSecondaryColorIsLight();
      temp['primaryColor'] = _primaryColor.value;
      temp['secondaryColor'] = _secondaryColor.value;
    }

    Files.jsonSettingFile.writeAsStringSync(jsonEncode(temp));
    notifyListeners();
  }

  void restoreDefault() {
    Map<String, dynamic> temp =
        jsonDecode(Files.jsonSettingFile.readAsStringSync());
    temp['primaryColor'] = Colors.grey[900].value;
    temp['secondaryColor'] = Colors.grey[200].value;
    temp['isDarkTheme'] = true;
    temp['fontFamily'] = 'Catamaran';
    Files.jsonSettingFile.writeAsStringSync(jsonEncode(temp));

    _primaryColor = Colors.grey[900];
    _secondaryColor = Colors.grey[200];
    _themeModeIsDark = true;
    _fontFamily = 'Catamaran';
    setSecondaryColorIsLight();
    notifyListeners();
  }
}
