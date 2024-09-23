import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier{

  int _selectStatus = 0;
  bool _isAppointmentDetail = false;

  int get selectStatus => _selectStatus;
  bool get isAppointmentDetail => _isAppointmentDetail;

  setStatus(index){
    _selectStatus = index;
    notifyListeners();
  }

  setAppointmentScreen(value){
    _isAppointmentDetail = value;
    notifyListeners();
  }

}