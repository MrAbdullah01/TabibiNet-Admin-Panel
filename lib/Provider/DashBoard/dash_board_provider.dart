import 'package:flutter/material.dart';

class DashBoardProvider extends ChangeNotifier{

  int _selectIndex = 6;

  int get selectIndex => _selectIndex;

  setSelectedIndex(index){
    _selectIndex = index;
    notifyListeners();
  }

}