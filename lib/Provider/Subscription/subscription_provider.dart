import 'package:flutter/material.dart';

class SubscriptionProvider extends ChangeNotifier{

  int _selectPlan = 0;
  bool _isEditSub = false;

  int get selectPlan => _selectPlan;
  bool get isEditSub => _isEditSub;

  setPlan(index){
    _selectPlan = index;
    notifyListeners();
  }

  setSub(bool isEdit){
    _isEditSub = isEdit;
    notifyListeners();
  }

}