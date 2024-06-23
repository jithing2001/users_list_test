import 'package:hive/hive.dart';
import 'package:hivetest/services/db_services/hive_db.dart';
import 'package:hivetest/utils/globals.dart';

class HiveService {
  // Method to save user data in the Hive database
  static Future<void> saveUserData(List<UserModel> userData) async {
    final box = await Hive.openBox<UserModel>(Globals.userBoxKey);
    await box.clear();
    // Add each user in the provided userData list to the box
    for (var user in userData) {
      await box.add(user);
    }
  }

  // Method to retrieve user data from the Hive database
  static Future<List<UserModel>> getUserData() async {
    final box = await Hive.openBox<UserModel>(Globals.userBoxKey);
    // Retrieve all values (user data) from the box and convert to a list
    final List<UserModel> userData = box.values.toList();
    // Return the retrieved user data list
    return userData;
  }
}
