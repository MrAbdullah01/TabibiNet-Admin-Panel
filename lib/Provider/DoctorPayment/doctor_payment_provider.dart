import 'package:flutter/material.dart';

class DoctorPaymentProvider extends ChangeNotifier{

  int? _selectedIndex;

  int? get selectIndex => _selectedIndex;

  setIndex(index){
    if(_selectedIndex != index){
      _selectedIndex = index;
    }else{
      _selectedIndex = null;
    }
    notifyListeners();
  }

}