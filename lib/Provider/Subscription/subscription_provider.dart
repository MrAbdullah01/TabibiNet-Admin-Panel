import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tabibinet_admin_panel/Model/data/user_model.dart';

import '../../Model/Res/Constants/firebase.dart';

class SubscriptionProvider extends ChangeNotifier{

  int _selectPlan = 0;
  String? _selectSub;
  String _subscription = "Basic";
  bool _isEditSub = false;

  int get selectPlan => _selectPlan;
  String? get selectSub => _selectSub;
  String get subscription => _subscription;
  bool get isEditSub => _isEditSub;

  setPlan(index){
    _selectPlan = index;
    if(index == 0){
      _subscription = "Basic";
    }
    else if(index == 1){
      _subscription = "Premium";
    }
    else{
      _subscription = "Advanced";
    }
    log('Selected Plan: $_subscription');  // Log the selected plan

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
    log('Fetching users with subscription: $_subscription');
    return fireStore.collection('users')
        .where("userType", isEqualTo: "Health Professional")
        .where("memberShip", isEqualTo: _subscription)
        .snapshots().map((snapshot) {
      log('Fetched ${snapshot.docs.length} users');
      return snapshot.docs.map((doc) => UserModel.fromDocumentSnapshot(doc)).toList();
    });
  }
  // Stream<List<UserModel>> fetchUsers() {
  //   log('Subscribing to user data...');
  //
  //   // Listen to Firestore snapshots and apply the query with two conditions
  //   return fireStore.collection('users')
  //       .where("userType", isEqualTo: "Health Professional")
  //       .where("memberShip", isEqualTo: "Premium")
  //       .snapshots().map((QuerySnapshot snapshot) {
  //     // Log how many documents are returned
  //     log('Fetched ${snapshot.docs.length} users');
  //
  //     // Log raw data from each document to check the results
  //     for (var doc in snapshot.docs) {
  //       log('Document data: ${doc.data()}');
  //     }
  //
  //     // Map documents to UserModel and return the list
  //     return snapshot.docs.map((QueryDocumentSnapshot doc) {
  //       return UserModel.fromDocumentSnapshot(doc);
  //     }).toList();
  //   });
  // }




  ///to show the user data////////
  String _name = '';
  String _email = '';
  String _number = '';
  String _status = '';
  String _id = '';

  // Getters
  String get name => _name;
  String get email => _email;
  String get number => _number;
  String get status => _status;
  String get id => _id;

// Setters


  void setSubscriptionDataDetails({
    required String name,
    required String email,
    required String number,
    required String status,
    required String id,
  }) {
    _name = name;
    _email = email;
    _number = number;
    _id = id;
    _status = status; // Update the status of the user
    notifyListeners(); // Notify listeners when data is updated
  }


}