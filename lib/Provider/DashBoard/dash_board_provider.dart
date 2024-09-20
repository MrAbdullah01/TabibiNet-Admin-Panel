import 'package:flutter/material.dart';

class DashBoardProvider extends ChangeNotifier{

  int _selectIndex = 0;
  bool _isNotification = false;
  bool _isProfile = false;
  bool _isEditProfile = false;
  bool _isSetting = false;
  bool _isDashBoard = true;

  int get selectIndex => _selectIndex;
  bool get isNotification => _isNotification;
  bool get isProfile => _isProfile;
  bool get isEditProfile => _isEditProfile;
  bool get isSetting => _isSetting;
  bool get isDashBoard => _isDashBoard;

  setSelectedIndex(index){
    _selectIndex = index;
    notifyListeners();
  }

  setNotification(notification){
    _isNotification = notification;
    notifyListeners();
  }

  setProfile(){
    _isProfile = true;
    _isDashBoard = false;
    _isEditProfile = false;
    _isSetting = false;
    notifyListeners();
  }

  setDashBoard(){
    _isProfile = false;
    _isDashBoard = true;
    _isEditProfile = false;
    _isSetting = false;
    notifyListeners();
  }

  setEditProfile(){
    _isProfile = false;
    _isDashBoard = false;
    _isEditProfile = true;
    _isSetting = false;
    notifyListeners();
  }

  setSetting(){
    _isProfile = false;
    _isDashBoard = false;
    _isEditProfile = false;
    _isSetting = true;
    notifyListeners();
  }

}