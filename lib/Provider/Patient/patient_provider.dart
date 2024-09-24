import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientProvider extends ChangeNotifier {

  bool _isAddPatient = false;

  bool get isAddPatient => _isAddPatient;

  setAddPatient(bool addPatient){
    _isAddPatient = addPatient;
    notifyListeners();
  }


  //////////////////////////search query for pateints/////////////


  String _searchQuery = '';
  List<QueryDocumentSnapshot> _filteredPatients = [];
  List<QueryDocumentSnapshot> _allPatients = [];

  String get searchQuery => _searchQuery;
  List<QueryDocumentSnapshot> get filteredPatients => _filteredPatients;

  // Method to set the search query and trigger filtering
  void setSearchQuery(String query) {
    _searchQuery = query;
    filterPatients();
    notifyListeners();
  }

  // Method to set the complete list of patients
  void setPatients(List<QueryDocumentSnapshot> patients) {
    _allPatients = patients;
    filterPatients();  // Apply the initial filter
  }

  // Filtering logic
  void filterPatients() {
    if (_searchQuery.isEmpty) {
      // Show all patients if no search query is entered
      _filteredPatients = _allPatients;
    } else {
      // Filter patients whose name starts with the search query
      _filteredPatients = _allPatients.where((user) {
        final name = user['name'].toString().toLowerCase();
        return name.startsWith(_searchQuery.toLowerCase());  // Filtering by the starting characters
      }).toList();
    }
  }

}