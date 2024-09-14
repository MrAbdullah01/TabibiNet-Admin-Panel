import 'package:flutter/material.dart';

class LogInProvider extends ChangeNotifier {

   bool _isVisible = true;

  bool get isVisible => _isVisible;

  setPasswordVisibility(){
    _isVisible = !_isVisible;
    notifyListeners();
  }

}