 
import 'package:flutter/cupertino.dart';

class ChangeLanguageProvider with ChangeNotifier {
  bool? arabic;

  Locale _currentLocale = const Locale("en");
  Locale get currentLocale => _currentLocale;
  chnagelanguage(String _locale) {
    arabic = false;
    _currentLocale = Locale(_locale);

    if (_locale == "ar") {
      arabic = true;
      print("Arabic value is $arabic");
    } else {}
    print(_currentLocale);
    print(arabic);
    notifyListeners();
    return arabic;
  }
}

 
