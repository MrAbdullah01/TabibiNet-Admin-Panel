import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProfileInfoProvider with ChangeNotifier {
  String? _profileImageUrl;
  String? _profileName;
  String? _profileLastName;
  String? _profileEmail;
  String? _profilePhone;
  String? _profileAddress;

  String? get profileImageUrl => _profileImageUrl;
  String? get profileName => _profileName;
  String? get profileLastName => _profileLastName;
  String? get profileEmail => _profileEmail;
  String? get profilePhone => _profilePhone;
  String? get profileAddress => _profileAddress;

  // Method to set the profile information and notify listeners
  void setProfileInfo(String imageUrl, String firstName, String lastName, String email,phone,address) {
    _profileImageUrl = imageUrl;
    _profileName = firstName;
    _profileLastName = lastName;
    _profileEmail = email;
    _profilePhone = phone;
    _profileAddress = address;
    notifyListeners();
  }

  // Method to listen to real-time profile updates
  void listenToProfileInfo() {
    // Listening for changes in the Firestore document
    FirebaseFirestore.instance
        .collection('admin')
        .doc("XcZeK5QjfBpZkrp03pGD") // Replace with your document ID
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        // Extract data from the snapshot
        final data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          // Extract the necessary fields with null checks
          String imageUrl = data['imageUrl'] ?? '';
          String firstName = data['firstName'] ?? 'Unknown';
          String lastName = data['lastName'] ?? 'Unknown';
          String email = data['email'] ?? 'Unknown';
          String phone = data['phoneNumber'] ?? 'Unknown';
          String address = data['address'] ?? 'Unknown';

          // Update the profile information
          setProfileInfo(imageUrl, firstName, lastName, email,phone,address);
        }
      } else {
        if (kDebugMode) {
          print("Profile document does not exist");
        }
      }
    }, onError: (error) {
      if (kDebugMode) {
        print("Error listening to profile updates: $error");
      }
    });
  }
}
