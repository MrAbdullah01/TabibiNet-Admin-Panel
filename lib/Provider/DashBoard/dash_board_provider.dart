import 'package:flutter/material.dart';

class DashBoardProvider extends ChangeNotifier{

  int _selectIndex = 0;
  bool _isNotification = false;

  int get selectIndex => _selectIndex;
  bool get isNotification => _isNotification;

  setSelectedIndex(index){
    _selectIndex = index;
    notifyListeners();
  }

  setNotification(notification){
    _isNotification = notification;
    notifyListeners();
  }

}