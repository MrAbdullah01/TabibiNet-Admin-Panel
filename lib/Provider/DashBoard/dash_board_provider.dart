import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashBoardProvider extends ChangeNotifier{

  int _selectIndex = 0;
  bool _isNotification = false;

  int get selectIndex => _selectIndex;
  bool get isNotification => _isNotification;

  setSelectedIndex(index){
    _selectIndex = index;
    notifyListeners();
  }

  setNotification(notification){
    _isNotification = notification;
    notifyListeners();
  }


  ///to show numbers in dashboardsection //////////////
///
  int patientCount = 0;
  int doctorCount = 0;
  int appointmentCount = 0;
  int appointmentCancelCount = 0;
  int subscriptionCount = 0;
  int basicCount = 0;
  int premiumCount = 0;
  int advancedCount = 0;
  int totalSubscriptions = 0;

  // Method to listen to real-time updates for patients
  void listenToPatientsCount() {
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'Patient')
        .snapshots()
        .listen((snapshot) {
      patientCount = snapshot.docs.length;
      notifyListeners(); // Notify listeners to rebuild UI when count changes
    });
  }

  // Method to listen to real-time updates for doctors
  void listenToDoctorsCount() {
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'Health Professional')
        .snapshots()
        .listen((snapshot) {
      doctorCount = snapshot.docs.length;
      notifyListeners(); // Notify listeners to rebuild UI when count changes
    });
  }

  // Method to listen to real-time updates for appointments
  void listenToAppointmentCount() {
    FirebaseFirestore.instance
        .collection('appointment')
        .snapshots()
        .listen((snapshot) {
      appointmentCount = snapshot.docs.length;
      notifyListeners(); // Notify listeners to rebuild UI when count changes
    });
  }

  void listenToCancelAppointmentCount() {
    FirebaseFirestore.instance
        .collection('appointment')
        .where('status', isEqualTo: 'cancel')
        .snapshots()
        .listen((snapshot) {
      appointmentCancelCount = snapshot.docs.length;
      notifyListeners(); // Notify listeners to rebuild UI when count changes
    });
  }
  void listenToSubscriptionCount() {
    // Fetch Basic membership count
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'Health Professional')
        .where('memberShip', isEqualTo: 'Basic')
        .snapshots()
        .listen((snapshot) {
      basicCount = snapshot.docs.length;
      updateTotalSubscriptions();
    });

    // Fetch Premium membership count
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'Health Professional')
        .where('memberShip', isEqualTo: 'Premium')
        .snapshots()
        .listen((snapshot) {
      premiumCount = snapshot.docs.length;
      updateTotalSubscriptions();
    });

    // Fetch Advanced membership count
    FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'Health Professional')
        .where('memberShip', isEqualTo: 'Advanced')
        .snapshots()
        .listen((snapshot) {
      advancedCount = snapshot.docs.length;
      updateTotalSubscriptions();
    });

  }
  // Function to calculate the total number of subscriptions
  void updateTotalSubscriptions() {
    totalSubscriptions = basicCount + premiumCount + advancedCount;
    notifyListeners(); // Notify listeners to update UI
  }

  // Initialize listeners for both counts
  void initializeListeners() {
    listenToPatientsCount();
    listenToDoctorsCount();
    listenToAppointmentCount();
    listenToCancelAppointmentCount();
    listenToSubscriptionCount();
    updateTotalSubscriptions();
  }


}