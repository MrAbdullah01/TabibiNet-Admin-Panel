import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ActionProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  final Map<int, bool> _isHovered = {};
  final Map<int, bool> _isLoading = {};

  Map<int, bool> _isCardHovered = {};

  bool isCardHovered(int index) => _isCardHovered[index] ?? false;

  void setHover(int index, bool value) {
    _isCardHovered[index] = value;
    notifyListeners();
  }

  static final ActionProvider _instance = ActionProvider._internal();
  factory ActionProvider() => _instance;
  ActionProvider._internal();

  int get selectedIndex => _selectedIndex;
  bool  isHovered(int index) => _isHovered[index] ?? false;
  bool  isLoading(int index) => _isLoading[index] ?? false;

  void selectMenu(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void onHover(int index,bool isHovered) {
    _isHovered[index] = isHovered;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _isLoading[0] = isLoading;
    notifyListeners();
  }

  // Static methods to start and stop loading globally
  static void startLoading() {
    _instance.setLoading(true);
  }

  static void stopLoading() {
    _instance.setLoading(false);
  }
///to update the value of button on updating speciality
  String _buttonText = 'Add';
  String _buttonFaqText = 'Delete';
  String _buttonLoginText = 'Login';
  String? _editingId;
  bool _isUpdate = false;
  String get buttonText => _buttonText;
  String get buttonFaqText => _buttonFaqText;
  String get buttonLoginText => _buttonLoginText;
  String? get editingId => _editingId;
  bool get isUpdate => _isUpdate;

  void setEditingMode(String id) {
    _buttonText = 'Update';
    _buttonFaqText = 'Update';
    _buttonLoginText = 'Update Password';
    _editingId = id;
    notifyListeners();
  }
  void setLoginMode(bool value) {
    _buttonLoginText = 'Update Password';
    _isUpdate = value;
    notifyListeners();
  }

  void resetMode() {
    _buttonText = 'Add';
    _buttonFaqText = 'Delete';
    _buttonLoginText = 'Login';
    _editingId = null;
    _isUpdate = false;
    notifyListeners();
  }



  final Map<String, bool> _loadingStates = {};
  bool isLoadingState(String key) => _loadingStates[key] ?? false;

  void setLoadingState(String key, bool loading) {
    _loadingStates[key] = loading;
    notifyListeners();
  }


  bool _isFooterHovered = false;

  bool get isFooterHovered => _isFooterHovered;

  void setHovered(bool value) {
    _isFooterHovered = value;
    notifyListeners();
  }

  int _hoveredIndex = -1;

  int get hoveredIndex => _hoveredIndex;

  void setHoveredIndex(int index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  void clearHover() {
    _hoveredIndex = -1;
    notifyListeners();
  }


  bool _isEditVisible = false;
  bool get isEditVisible => _isEditVisible;

  void setEditVisible(bool value) {
    _isEditVisible = value;
    notifyListeners();
  }


  final GlobalKey<ScaffoldState> _scaffoldKeyDashboard = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKeyDashboard;

  void controlMenuDashboard() {
    if (!_scaffoldKeyDashboard.currentState!.isDrawerOpen) {
      _scaffoldKeyDashboard.currentState!.openDrawer();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKeyInstructor = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKeyInstructor => _scaffoldKeyInstructor;

  void controlMenuInstructor() {
    if (!_scaffoldKeyInstructor.currentState!.isDrawerOpen) {
      _scaffoldKeyInstructor.currentState!.openDrawer();
    }
  }


  // date picker d
  DateTime? _selectedDateTime;

  DateTime? get selectedDateTime => _selectedDateTime;

  void setDateTime(DateTime dateTime) {
    _selectedDateTime = dateTime;
    notifyListeners();
  }

  DateTimeRange? _selectedDateTimeRange;

  DateTimeRange? get selectedDateTimeRange => _selectedDateTimeRange;

  // void setDateTimeRange(DateTimeRange dateTimeRange) {
  //   _selectedDateTimeRange = dateTimeRange;
  //   notifyListeners();
  // }

  // DateTimeRange? _selectedDateTimeRange;

  DateTime? _startDate;
  DateTime? _endDate;

  // Getter for start date
  DateTime? get startDate => _startDate;

  // Getter for end date
  DateTime? get endDate => _endDate;

  // Getter for the entire date range
  // DateTimeRange? get selectedDateTimeRange => _selectedDateTimeRange;

  // Method to set the date range and update start and end dates
  void setDateTimeRange(DateTimeRange dateTimeRange) {
    _selectedDateTimeRange = dateTimeRange;
    _startDate = dateTimeRange.start;
    _endDate = dateTimeRange.end;
    notifyListeners();  // Notify listeners (UI will be updated)
  }
  //////////////forget password/////////////



  bool _isForgetPasswordVisible = false;

  bool get isForgetPasswordVisible => _isForgetPasswordVisible;

  void toggleForgetPasswordField() {
    _isForgetPasswordVisible = !_isForgetPasswordVisible;
    notifyListeners();
  }


}