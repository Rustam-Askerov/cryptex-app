import 'package:flutter/foundation.dart';

class UserData with ChangeNotifier {
  String _id = "";
  int _rank = -1;
  String _symbol = "";
  String _name = "";
  double _priceUsd = 0;
  double _changePercent24Hr = 0;

  String get id => _id;
  int get rank => _rank;
  String get symbol => _symbol;
  String get name => _name;
  double get priceUsd => _priceUsd;
  double get changePercent24Hr => _changePercent24Hr;

  set setId(String value) {
    _id = value;
    notifyListeners();
  }

  set setRank(int value) {
    _rank = value;
    notifyListeners();
  }

  set setSymbol(String value) {
    _symbol = value;
    notifyListeners();
  }

  set setName(String value) {
    _name = value;
    notifyListeners();
  }

  set setPriceUsd(double value) {
    _priceUsd = value;
    notifyListeners();
  }

  set setChangePercent24Hr(double value) {
    _changePercent24Hr = value;
    notifyListeners();
  }
}
