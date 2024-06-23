import 'package:hivetest/services/db_services/hive_db.dart';
import 'package:hivetest/views/common/alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

class GetAPi {
  // Method to fetch user data from the API
  static Future<List<UserModel>> fetchUserData() async {
    try {
      // Check the current internet connectivity status
      var connectivityResult = await Connectivity().checkConnectivity();

      // If there is no mobile data or Wi-Fi connection, show a toast and throw an error
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        Alert.showToast("Please check your internet connection");
        throw "No internet connection";
      }

      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List<UserModel> list = [];

        for (var element in data) {
          list.add(UserModel.fromJson(element));
        }
        // Return the list of UserModel instances
        return list;
      } else {
        throw "Failed to load data";
      }
    } catch (e) {
      rethrow;
    }
  }
}
