import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gold_swing/ihelper/shared_variables.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedMethods {
  // Convert the time stamp to date time format
  static String convertTimesTampToDateTime(int timesTamp) {
    // 1743239762
    // Convert timestamp to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timesTamp * 1000);

    // Format date
    //String formattedDate = DateFormat('MMM d, y – h:mm a').format(dateTime);
    String formattedDate = DateFormat('dd/MM/yyyy h:mm a').format(dateTime);

    return formattedDate;
  }

  // Return the current time stamp in milliseconds
  static int getCurrentTimesTamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  // Show snake bar message for operation result
  static void msgOperationResult(BuildContext ctx, String msg, Color color) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  // Check if internet is working or not
  static Future<bool> isInternetWorking() async {
    // flutter pub add connectivity_plus
    // import 'package:connectivity_plus/connectivity_plus.dart';
    // Check connectivity
    var internetStatus = await Connectivity().checkConnectivity();
    if (internetStatus.contains(ConnectivityResult.wifi) ||
        internetStatus.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }

  // save Api key in shared_preferences
  static Future<bool> apikeySet(String keyValue) async {
    final sharePref = await SharedPreferences.getInstance();
    bool success = await sharePref.setString(mySharedPrefApiKey, keyValue);
    return success;
  }

  static Future<String> apiKeyGet(String mySharedPrefApiKey) async {
    final sharePref = await SharedPreferences.getInstance();
    String currentValue = sharePref.getString(mySharedPrefApiKey) ?? '';
    return currentValue;
  }

  static Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    myAppVersion = 'Version: ${packageInfo.version}';
    //return 'Version: ${packageInfo.version} (Build ${packageInfo.buildNumber})';
  }

  // Exit App
  static void exitApp() {
    if (Platform.isAndroid) {
      // For Android
      SystemNavigator.pop(); // This is the recommended way
    } else if (Platform.isIOS) {
      // For iOS (not recommended by Apple guidelines)
      exit(0); // Requires dart:io
    }
  }
}
