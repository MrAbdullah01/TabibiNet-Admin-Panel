import 'package:flutter/material.dart';

class SubscriptionProvider extends ChangeNotifier{

  int _selectPlan = 0;
  String? _selectSub;
  bool _isEditSub = false;

  int get selectPlan => _selectPlan;
  String? get selectSub => _selectSub;
  bool get isEditSub => _isEditSub;

  setPlan(index){
    _selectPlan = index;
    notifyListeners();
  }

  setSub(bool isEdit){
    _isEditSub = isEdit;
    notifyListeners();
  }

  setSubscription(value){
    _selectSub = value;
    notifyListeners();
  }

}