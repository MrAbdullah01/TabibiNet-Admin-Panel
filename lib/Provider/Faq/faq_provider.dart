import 'package:flutter/material.dart';

class FaqProvider extends ChangeNotifier{

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