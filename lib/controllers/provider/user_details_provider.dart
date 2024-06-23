import 'package:flutter/material.dart'; // Import Flutter's material package for UI components
import 'package:hivetest/services/api_services.dart/api_call.dart'; // Import the API service for fetching user data
import 'package:hivetest/services/db_services/hive_db.dart'; // Import the Hive database service
import 'package:hivetest/services/db_services/hive_services.dart'; // Import the Hive service for database operations

class UserDataProvider extends ChangeNotifier {
  UserDataProvider() {
    initUserData();
  }

  List<UserModel> _userData = [];
  String? _error;
  bool isLoading = true;

  // Public getter to access user data
  List<UserModel> get userData => _userData;

  // Public getter to access error message
  String? get error => _error;

  void initUserData({bool isrefresh = false}) async {
    _error = null;

    // If not refreshing, set loading state to true and notify listeners
    if (!isrefresh) {
      isLoading = true;
      notifyListeners();
    }

    // Fetch user data from Hive database
    await HiveService.getUserData().then((value) {
      // If there is data in Hive and userData list is empty, update userData
      if (value.isNotEmpty && userData.isEmpty) {
        _userData = value;
      }
    });

    // Fetch user data from API
    await GetAPi.fetchUserData().then((value) async {
      // If API returns data, update userData and save it to Hive database
      if (value.isNotEmpty) {
        _userData = value;
        await HiveService.saveUserData(userData);
      }
    }).catchError((error) {
      // If an error occurs, set the error message
      _error = '$error';
    });

    // Set loading state to false and notify listeners
    isLoading = false;
    notifyListeners();
  }
}
