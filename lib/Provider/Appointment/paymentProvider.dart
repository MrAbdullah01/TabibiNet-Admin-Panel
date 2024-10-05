import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../Model/data/paymentModel/paymentModel.dart';

class PaymentProvider with ChangeNotifier {
  List<PaymentModel> _appointments = [];
  bool _isLoading = true;

  List<PaymentModel> get appointments => _appointments;
  bool get isLoading => _isLoading;

  PaymentProvider() {
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('appointment').get();
      _appointments = querySnapshot.docs
          .map((doc) => PaymentModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)) // Pass doc.id
          .toList();
    } catch (e) {
      // Handle any errors that occur during fetching
      log("Error fetching appointments: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
