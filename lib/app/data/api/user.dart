import 'package:flutter/material.dart';
import 'package:react_native_test/app/app.dart';

class UserApi {
  static Future<UserModel?> getUser() async {
    try {
      String path =
          '${Constants.baseUrl}/api/shifts/map-list-unauthorized?latitude=45.039268&longitude=38.987221';
      final response = await HttpUtil().get(path: path);

      return UserModel.fromJson(response);
    } catch (e) {
      debugPrint('Error get Home: $e');
      return null;
    }
  }
}
