import 'package:flutter/cupertino.dart';

class HealthCareProvider extends ChangeNotifier{

  int _selectIndex = 0;
  String? selectedSpecialtyId,_name;


  int get selectIndex => _selectIndex;
  String? get name => _name;

  setIndex(index){
    _selectIndex = index;
    notifyListeners();
  }

  void setSelectedSpecialty(String specialtyId,name) {
    selectedSpecialtyId = specialtyId;
    _name = name;
    notifyListeners();
  }

}