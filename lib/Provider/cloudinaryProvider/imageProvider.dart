import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CloudinaryProvider with ChangeNotifier {
  final String _cloudName = 'dz0mfu819';
  final String _uploadPreset = 'ml_default'; // Set up an unsigned upload preset in Cloudinary

  String _imageUrl = '';

  Uint8List? _imageData;



  String get imageUrl => _imageUrl;
  Uint8List? get imageData => _imageData;

  //to display image in container
  void setImageData(Uint8List bytes) {
    _imageData = bytes;

    notifyListeners();
  }

  // clear image
  void clearImage() {
    _imageData = null;
    notifyListeners();
  }

  Future<void> uploadImage(Uint8List imageBytes) async {
    //cloud name
    const String cloudName = 'dz0mfu819';
    //folder name
    const String uploadPreset = 'ml_default	';
    const String folderName = 'images'; // Specify the folder
// signed preset

    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = folderName // Add the folder parameter
      ..files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: 'image.jpg'));

    try {
      final response = await request.send();
      log("Status Code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        _imageUrl = jsonResponse['secure_url'];
        log("Image Url:: ${jsonResponse['secure_url']}");
        notifyListeners(); // Notify listeners about the change
      } else {
        final responseBody = await response.stream.bytesToString();
        log("Response Body:: $responseBody");
        throw Exception('Failed to upload image: $responseBody');
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}