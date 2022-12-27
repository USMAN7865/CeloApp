import 'package:flutter/cupertino.dart';

class GetUserDataProvider with ChangeNotifier {
  String _userid = "";
  String get userid => _userid;

  setUserId(String userid) {
    _userid = userid;
    notifyListeners();
    print(userid);
  }
  String _gender = "";
  String get gender => _gender;

  setUsergender(String usergender) {
    _gender = usergender;
    notifyListeners();
    print(usergender);
  }

  String _motive = "";
  String get motive => _motive;

  setUsermotive(String motive) {
    _motive = motive;
    print(_motive);
    notifyListeners();
  }
  String _getuserlocation = "";
  String get location => _getuserlocation;

  setUserlocation(String location) {
    _getuserlocation = location;
    print(_motive);
    notifyListeners();
  }

  String _age = "";
  String get age => _age;

  setUserage(String userage) {
    _age = userage;
    print(_age);
    notifyListeners();
  }

  double _height = 0.0;
  double get height => _height;

  setUserheight(double height) {
    _height = height;
    // print(_height);
    notifyListeners();
  }

  double _weight = 0.0;
  double get weight => _weight;

  setUserweight(double weight) {
    _weight = weight;
    print(_weight);
    notifyListeners();
  }

  double _weightarget = 0.0;
  double get weightarget => _weightarget;

  setUsertargetweight(double weightarget) {
    _weightarget = weightarget;
    print(_weightarget);
    notifyListeners();
  }

  String _currentlydietplan = "";
  String get currentlydietplan => _currentlydietplan;

  setUsercurrrentplan(String currentlydietplan) {
    _currentlydietplan = currentlydietplan;
    print(_currentlydietplan);
    notifyListeners();
  }

  String _dietplan = "";
  String get dietplan => _dietplan;

  setUserdietplan(String dietplan) {
    _dietplan = dietplan;
    print(_dietplan);
    notifyListeners();
  }

  String _exceptfood = "";
  String get exceptfood => _exceptfood;

  setUserexceptfood(String exceptfood) {
    _exceptfood = exceptfood;
    print(_exceptfood);
    notifyListeners();
  }

  /// For get Fats Data
  ///
  String _currentlycalories = "";
  String get currentlycalories => _currentlycalories;

  setUsercurrrentcalories(String currentlycalories) {
    _currentlycalories = currentlycalories;
    print(currentlycalories);
    notifyListeners();
  }

  String _currentlyfats = "";
  String get currentlyfats => _currentlyfats;

  setUserfats(String currentlyfats) {
    _currentlyfats = currentlyfats;
    print(_dietplan);
    notifyListeners();
  }

  String _currentlyprotein = "";
  String get userProtein => _currentlyprotein;

  setUserprotein(String userProtein) {
    _currentlyprotein = userProtein;
    print(_currentlyprotein);
    notifyListeners();
  }

  String _currentlyCarbs = "";
  String get userCarbs => _currentlyCarbs;

  setUsercarbs(String userCarbs) {
    _currentlyCarbs = userCarbs;
    print(_currentlyCarbs);
    notifyListeners();
  }
}
