import 'package:flutter/material.dart';

class FaqProvider extends ChangeNotifier{
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

  void toggleFaq(int index) {
    if (_selectedIndex == index) {
      _selectedIndex = -1; // Deselect if the same question is clicked
    } else {
      _selectedIndex = index; // Set the new index
    }
    notifyListeners();
  }


  int? _selectFaq;
  bool _isAddFaq = true;

  int? get selectFaq => _selectFaq;
  bool get isAddFaq => _isAddFaq;

  setFaq(index){
    _selectFaq = index;
    notifyListeners();
  }

  setAddFaq(addFaq){
    _isAddFaq = addFaq;
    notifyListeners();
  }

}