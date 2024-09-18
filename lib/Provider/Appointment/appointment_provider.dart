import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier{

  int _selectStatus = 0;

  int get selectStatus => _selectStatus;

  setStatus(index){
    _selectStatus = index;
    notifyListeners();
  }

}