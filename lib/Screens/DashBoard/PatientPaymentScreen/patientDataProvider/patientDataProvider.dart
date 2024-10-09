import 'dart:developer';

import 'package:flutter/material.dart';

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
    _feesId = feesId; // Corrected assignment error
    _patientPhone = patientPhone;
    // Debug prints
    notifyListeners(); // Notify listeners when patient data is updated
  }

  // Setters for Doctor Data
  void setDoctorDataDetails({
    required String doctorName,
    required String fees,
    required String feesId,
    required String doctorLocation,
    required String docPhoneNumber,
  }) {
    _doctorName = doctorName;
    _fees = fees;
    _feesId = feesId;
    _doctorLocation = doctorLocation;
    _docPhoneNumber = docPhoneNumber;

    notifyListeners(); // Notify listeners when doctor data is updated
  }
}
