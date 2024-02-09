import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user');

    if (userDataString != null) {
      Map<String, dynamic> userDataMap = Map.from(json.decode(userDataString));

      return userDataMap;
    } else {
      return null;
    }
  }
}
