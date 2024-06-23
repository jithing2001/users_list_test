import 'package:hivetest/services/db_services/hive_db.dart';
import 'package:hivetest/views/common/alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class GetAPi {
  static Future<List<UserModel>> fetchUserData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        Alert.showToast("Please check your internet connection");
        throw "No internet connection";
      }
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<UserModel> list = [];
        for (var element in data) {
          list.add(UserModel.fromJson(element));
        }
        return list;
      } else {
        throw "Failed to load data";
      }
    } catch (e) {
      rethrow;
    }
  }
}
