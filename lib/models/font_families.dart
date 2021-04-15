import 'dart:collection';

class FontFamily {
  List<String> _fontFamilyList = [
    'BerkshireSwash',
    'Chewy',
    'Catamaran',
    'CourierPrime',
    'IndieFlower',
    'LeckerliOne',
    'LobsterTwo',
    'Lora',
    'Merienda',
    'Montserrat',
    'OleoScript',
    'Pacifico',
    'PermanentMarker',
    'Roboto',
    'Satisfy',
  ];

  UnmodifiableListView<String> get fontFamilyList {
    return UnmodifiableListView(_fontFamilyList);
  }

  int get fontFamilyListCount {
    return _fontFamilyList.length;
  }
}
