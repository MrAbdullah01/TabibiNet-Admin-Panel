import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tabibinet_admin_panel/Model/data/user_model.dart';

import '../../Model/Res/Constants/firebase.dart';

class SubscriptionProvider extends ChangeNotifier{

  int _selectPlan = 0;
  String? _selectSub;
  String? _subscription = "Free";
  bool _isEditSub = false;

  int get selectPlan => _selectPlan;
  String? get selectSub => _selectSub;
  String? get subscription => _subscription;
  bool get isEditSub => _isEditSub;

  setPlan(index){
    _selectPlan = index;
    if(index == 0){
      _subscription = "Free";
    }
    else if(index == 1){
      _subscription = "Premium";
    }
    else{
      _subscription = "Advanced";
    }
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

  Stream<List<UserModel>> fetchUsers() {
    return fireStore.collection('users')
        .where("userType",isEqualTo: "Health Professional")
        .where("memberShip",isEqualTo: _subscription)
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromDocumentSnapshot(doc)).toList();
    });
  }

}