import 'package:flutter/material.dart';

class LogInProvider extends ChangeNotifier {

   bool _isVisible = true;
   bool _isVisibleN = true;

  bool get isVisible => _isVisible;
  bool get isVisibleN => _isVisibleN;

  setPasswordVisibility(){
    _isVisible = !_isVisible;
    _isVisibleN = !_isVisibleN;
    notifyListeners();
  }

}