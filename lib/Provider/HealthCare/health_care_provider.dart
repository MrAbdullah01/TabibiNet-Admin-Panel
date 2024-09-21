import 'package:flutter/cupertino.dart';

class HealthCareProvider extends ChangeNotifier{

  int _selectIndex = 0;

  int get selectIndex => _selectIndex;

  setIndex(index){
    _selectIndex = index;
    notifyListeners();
  }

}