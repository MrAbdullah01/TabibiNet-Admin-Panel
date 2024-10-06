import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../Model/data/paymentModel/paymentModel.dart';

class PaymentProvider with ChangeNotifier {
  final List<PaymentModel> _appointments = [];

  List<PaymentModel> get appointments => _appointments;

  // Stream for real-time updates
  Stream<List<PaymentModel>> fetchAppointments() {
    return FirebaseFirestore.instance.collection('appointment').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PaymentModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

}
