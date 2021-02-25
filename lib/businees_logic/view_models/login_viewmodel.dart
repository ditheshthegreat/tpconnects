import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:tp_connects/businees_logic/model/user_details.dart';
import 'package:tp_connects/service/rest/RestAPI.dart';
import 'package:tp_connects/service/storage/user_dao.dart';

class LoginViewModel extends ChangeNotifier {
  RestAPI _restAPI = RestAPI();
  UserDao _userDao = UserDao();
  DefaultResponse defaultResponse = DefaultResponse();

  Future<void> userLogin(String phone, String password) async {
    try {
      var response = await _restAPI.post<Map<String, dynamic>>(
        RestAPI.userLogin,
        params: {
          "phone": phone,
          "password": password,
          "device_os": Platform.isIOS ? "IOS" : "Android",
          "device_token": "123456",
          "device_id": "123456"
        },
      );
      print("Response :: $response");
      if (response["status"]) {
        var userData = UserDetailsModel.fromJson(response);
        await _userDao.deleteDatabase();
        await _userDao.insert(userData);
        defaultResponse = DefaultResponse(status: true, userResponse: "Login Successfully");
      } else {
        var userErrorData = UserErrorModel.fromJson(response);
        defaultResponse = DefaultResponse(
            status: false,
            userResponse: userErrorData.result.errors.incorrectPassword != null
                ? "Password is incorrect"
                : "Username is incorrect");
      }
      notifyListeners();
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<UserDetailsModel> getUserDetails()async{
    return await _userDao.getUser();
  }
  Future<UserDetailsModel> deleteUserDatabase()async{
    return await _userDao.deleteDatabase();
  }
}

class DefaultResponse {
  final bool status;
  final String userResponse;

  DefaultResponse({this.status = false, this.userResponse = "Something went wrong please try again"});

  @override
  String toString() {
    return 'DefaultResponse{status: $status, userResponse: $userResponse}';
  }
}
