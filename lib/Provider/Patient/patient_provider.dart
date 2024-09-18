import 'package:flutter/material.dart';

class PatientProvider extends ChangeNotifier {

  bool _isAddPatient = false;

  bool get isAddPatient => _isAddPatient;

  setAddPatient(bool addPatient){
    _isAddPatient = addPatient;
    notifyListeners();
  }

}