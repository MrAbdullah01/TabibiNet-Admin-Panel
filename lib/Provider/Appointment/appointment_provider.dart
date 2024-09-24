import 'package:flutter/material.dart';

import '../../Screens/DashBoard/AppointmentScreen/Components/model/appointmentModel.dart';

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
    notifyListeners();
  }


///for dropdown
  String selectedStatus = '';

  void setStatusType(String newStatus) {
    selectedStatus = newStatus;
    notifyListeners();  // Notify listeners to update the UI
  }






  ///////for passing data to next screen
  bool isAppointmentDetails = false;
  AppointmentDetails? selectedAppointment;

  void setAppointmentsScreen(bool isDetail) {
    isAppointmentDetails = isDetail;
    notifyListeners();
  }

  void setSelectedAppointment(AppointmentDetails appointment) {
    selectedAppointment = appointment;
    notifyListeners();
  }
}