import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tabibinet_admin_panel/Model/data/user_model.dart';

class PatientDataProvider with ChangeNotifier {
  // Doctor Data
  String _doctorName = '';
  String _speciality = '';
  String _experience = '';
  String _membership = '';
  String _availabilityFrom = '';
  String _availabilityTo = '';
  String _country = '';
  String _phoneNumber = '';
  String _rating = '';
  String _reviews = '';

  // Patient Data
  String _patientName = '';
  String _patientPhone = '';
  String _patientProblem = '';
  String _patientAge = '';
  String _patientEmail = '';
  String _appointmentDate = '';
  String _fees = '';
  String _feesId = '';
  String _userType = '';
  String _doctorLocation = '';  // Could be removed if unnecessary for your logic
  String _docPhoneNumber = '';  // Could be removed if unnecessary for your logic
  String _doctorDescription = '';  // Could be removed if unnecessary for your logic
  String _doctorPhoto = '';  // Could be removed if unnecessary for your logic
  Map? _docModel;  // Could be removed if unnecessary for your logic

  // Getters for Doctor Data
  String get doctorName => _doctorName;
  String get speciality => _speciality;
  String get experience => _experience;
  String get membership => _membership;
  String get availabilityFrom => _availabilityFrom;
  String get availabilityTo => _availabilityTo;
  String get country => _country;
  String get phoneNumber => _phoneNumber;
  String get rating => _rating;
  String get reviews => _reviews;
  String get docPhoneNumber => _docPhoneNumber;
  String get doctorPhoto => _doctorPhoto;

  // Getters for Patient Data
  String get patientName => _patientName;
  String get patientEmail => _patientEmail;
  String get patientAge => _patientAge;
  String get patientPhone => _patientPhone;
  String get patientProblem => _patientProblem;
  String get appointmentDate => _appointmentDate;
  String get fees => _fees;
  String get feesId => _feesId;
  String get userType => _userType;
  String get doctorLocation => _doctorLocation;
  String get doctorDescription => _doctorDescription;
  Map? get docModel => _docModel;

  // Setters for Patient Data
  void setPatientDataDetails({
    required String patientName,
    required String appointmentDate,
    required String patientAge,
    required String patientEmail,
    required String patientProblem,
    required String fees,
    required String feesId,
    required String country,
    required String patientPhone,
    required String userType,
  }) {
    _patientName = patientName;
    _patientAge = patientAge;
    _patientEmail = patientEmail;
    _patientProblem = patientProblem;
    _fees = fees;
    _feesId = feesId;
    _patientPhone = patientPhone;
    notifyListeners();
  }

  // Setters for Doctor Data
  void setDoctorDataDetails({
     String? doctorName,
     String? doctorDescription,
     String? doctorPhoto,
     Map? docModel,
     String? fees,
     String? feesId,
     String? doctorLocation,
     String? docPhoneNumber,
  }) {
    _doctorName = doctorName!;
    _doctorDescription = doctorDescription!;
    _fees = fees!;
    _feesId = feesId!;
    _doctorLocation = doctorLocation!;
    _docPhoneNumber = docPhoneNumber!;
    _doctorPhoto = doctorPhoto!;
    _docModel = docModel;

    notifyListeners();
  }

  // clear all variables data
  void clearAllData() {
    _doctorName = '';
    _doctorPhoto = '';
    _speciality = '';
    _experience = '';
    _membership = '';
    _availabilityFrom = '';
    _availabilityTo = '';
    _country = '';
    _phoneNumber = '';
    _rating = '';
    _reviews = '';
    _patientName = '';
    _patientPhone = '';
    _patientProblem = '';
    _patientAge = '';
    _patientEmail = '';
    _appointmentDate = '';
    _fees = '';
    _feesId = '';
    _userType = '';
    _doctorLocation = '';
    _docPhoneNumber = '';
    _doctorDescription = '';
    notifyListeners(); // Notify listeners when all data is cleared
  }
}
