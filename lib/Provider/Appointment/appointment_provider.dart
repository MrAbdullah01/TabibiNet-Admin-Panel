import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier{

  int _selectStatus = 0;
  bool _isAppointmentDetail = false;

  String _changeFilter = "upcoming";

  int get selectStatus => _selectStatus;
  bool get isAppointmentDetail => _isAppointmentDetail;
  String get changeFilter => _changeFilter;

  setStatus(index){
    _selectStatus = index;
    notifyListeners();
  }

  setAppointmentScreen(value){
    _isAppointmentDetail = value;
    notifyListeners();
  }

  void updateFilter(String value){
    _changeFilter = value;
  }


///for dropdown
  String _selectedStatus = 'Choose Status';

  String get selectedStatus => _selectedStatus;

  void setStatusType(String status) {
    _selectedStatus = status;
    notifyListeners();
  }
}