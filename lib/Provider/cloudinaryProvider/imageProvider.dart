import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CloudinaryProvider with ChangeNotifier {
  final String _cloudName = 'dz0mfu819';
  final String _uploadPreset = 'tabibinet'; // Set up an unsigned upload preset in Cloudinary

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
    const String cloudName = 'dz0mfu819';
    const String uploadPreset = 'tabibinet';
    const String folderName = 'images'; // Specify the folder name here

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
        log("Image URL:: $_imageUrl");

        notifyListeners(); // Notify listeners about the change
      } else {
        final responseBody = await response.stream.bytesToString();
        log("Error Body:: $responseBody");
        throw Exception('Failed to upload image: $responseBody');
      }
    } catch (e) {
      log('Error uploading image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }


  ///for chat////////
  Future<Map<String, dynamic>?> uploadFireImage(Uint8List imageBytes, String fileName) async {
    // Replace the URL below with your Cloudinary upload URL
    const String cloudinaryUploadUrl = 'https://api.cloudinary.com/v1_1/YOUR_CLOUD_NAME/image/upload';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUploadUrl));
      request.fields['upload_preset'] = 'YOUR_UPLOAD_PRESET'; // Make sure to use your preset
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          imageBytes,
          filename: fileName,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final Map<String, dynamic> result = json.decode(responseData);

        // Return the URL of the uploaded image
        return {
          'url': result['secure_url'], // Get the secure URL from the response
        };
      } else {
        print('Upload failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }}