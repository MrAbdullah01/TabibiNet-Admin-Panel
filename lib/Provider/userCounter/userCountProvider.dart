import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserCountProvider with ChangeNotifier {
  Map<String, int> userCounts = {
    'Jan': 0,
    'Feb': 0,
    'Mar': 0,
    'Apr': 0,
    'May': 0,
    'Jun': 0,
    'Jul': 0,
    'Aug': 0,
    'Sep': 0,
    'Oct': 0,
    'Nov': 0,
    'Dec': 0,
  };

  bool isLoading = true;

  UserCountProvider() {
    fetchUserCountByMonth();
  }

  Future<void> fetchUserCountByMonth() async {
    Map<String, int> userCountByMonth = {
      'Jan': 0,
      'Feb': 0,
      'Mar': 0,
      'Apr': 0,
      'May': 0,
      'Jun': 0,
      'Jul': 0,
      'Aug': 0,
      'Sep': 0,
      'Oct': 0,
      'Nov': 0,
      'Dec': 0,
    };

    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();

      for (var doc in snapshot.docs) {
        if (doc['creationDate'] != null && doc['creationDate'] is Timestamp) {
          Timestamp joinDateTimestamp = doc['creationDate'];
          DateTime joinDate = joinDateTimestamp.toDate();
          String formattedDate = DateFormat('MMMM yyyy').format(joinDate);

          // Increment the count for the specific month
          String monthAbbreviation = formattedDate.substring(0, 3);
          if (userCountByMonth.containsKey(monthAbbreviation)) {
            userCountByMonth[monthAbbreviation] =
                userCountByMonth[monthAbbreviation]! + 1;
          }
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }

    userCounts = userCountByMonth;
    isLoading = false;
    notifyListeners();
  }
}
