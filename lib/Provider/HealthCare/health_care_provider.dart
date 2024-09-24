import 'package:flutter/cupertino.dart';

class HealthCareProvider extends ChangeNotifier{

  int _selectIndex = 0;
  String? selectedSpecialtyId;


  int get selectIndex => _selectIndex;

  setIndex(index){
    _selectIndex = index;
    notifyListeners();
  }

  void setSelectedSpecialty(String specialtyId) {
    selectedSpecialtyId = specialtyId;
    notifyListeners();
  }

}