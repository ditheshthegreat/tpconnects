// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
  UserDetailsModel({
    this.status,
    this.uname,
    this.panchayath,
    this.district,
    this.ward,
    this.isVolunteer,
    this.profileId,
    this.userToken,
    this.loginStatus,
    this.result,
  });

  bool status;
  String uname;
  String panchayath;
  String district;
  String ward;
  bool isVolunteer;
  String profileId;
  String userToken;
  int loginStatus;
  Result result;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        status: json["status"],
        uname: json["uname"],
        panchayath: json["panchayath"],
        district: json["district"],
        ward: json["ward"],
        isVolunteer: json["is_volunteer"],
        profileId: json["profile_id"],
        userToken: json["user_token"],
        loginStatus: json["login_status"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "uname": uname,
        "panchayath": panchayath,
        "district": district,
        "ward": ward,
        "is_volunteer": isVolunteer,
        "profile_id": profileId,
        "user_token": userToken,
        "login_status": loginStatus,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    this.data,
    this.id,
    this.caps,
    this.capKey,
    this.roles,
    this.allcaps,
    this.filter,
  });

  Data data;
  int id;
  Caps caps;
  String capKey;
  List<String> roles;
  Map<String, bool> allcaps;
  dynamic filter;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        data: Data.fromJson(json["data"]),
        id: json["ID"],
        caps: Caps.fromJson(json["caps"]),
        capKey: json["cap_key"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        allcaps: Map.from(json["allcaps"]).map((k, v) => MapEntry<String, bool>(k, v)),
        filter: json["filter"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "ID": id,
        "caps": caps.toJson(),
        "cap_key": capKey,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "allcaps": Map.from(allcaps).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "filter": filter,
      };
}

class Caps {
  Caps({
    this.pendingUser,
    this.bbpParticipant,
  });

  bool pendingUser;
  bool bbpParticipant;

  factory Caps.fromJson(Map<String, dynamic> json) => Caps(
        pendingUser: json["pending_user"],
        bbpParticipant: json["bbp_participant"],
      );

  Map<String, dynamic> toJson() => {
        "pending_user": pendingUser,
        "bbp_participant": bbpParticipant,
      };
}

class Data {
  Data({
    this.id,
    this.userLogin,
    this.userPass,
    this.userNicename,
    this.userEmail,
    this.userUrl,
    this.userRegistered,
    this.userActivationKey,
    this.userStatus,
    this.displayName,
    this.image,
  });

  String id;
  String userLogin;
  String userPass;
  String userNicename;
  String userEmail;
  String userUrl;
  DateTime userRegistered;
  String userActivationKey;
  String userStatus;
  String displayName;
  String image;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["ID"],
        userLogin: json["user_login"],
        userPass: json["user_pass"],
        userNicename: json["user_nicename"],
        userEmail: json["user_email"],
        userUrl: json["user_url"],
        userRegistered: DateTime.parse(json["user_registered"]),
        userActivationKey: json["user_activation_key"],
        userStatus: json["user_status"],
        displayName: json["display_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "user_login": userLogin,
        "user_pass": userPass,
        "user_nicename": userNicename,
        "user_email": userEmail,
        "user_url": userUrl,
        "user_registered": userRegistered.toIso8601String(),
        "user_activation_key": userActivationKey,
        "user_status": userStatus,
        "display_name": displayName,
        "image": image,
      };
}

///User Error Model
UserErrorModel userErrorModelFromJson(String str) => UserErrorModel.fromJson(json.decode(str));

String userErrorModelToJson(UserErrorModel data) => json.encode(data.toJson());

class UserErrorModel {
  UserErrorModel({
    this.status,
    this.uname,
    this.loginStatus,
    this.result,
  });

  bool status;
  String uname;
  int loginStatus;
  ErrorResult result;

  factory UserErrorModel.fromJson(Map<String, dynamic> json) => UserErrorModel(
        status: json["status"],
        uname: json["uname"],
        loginStatus: json["login_status"],
        result: ErrorResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "uname": uname,
        "login_status": loginStatus,
        "result": result.toJson(),
      };
}

class ErrorResult {
  ErrorResult({
    this.errors,
    this.errorData,
  });

  Errors errors;
  List<dynamic> errorData;

  factory ErrorResult.fromJson(Map<String, dynamic> json) => ErrorResult(
        errors: Errors.fromJson(json["errors"]),
        errorData: List<dynamic>.from(json["error_data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors.toJson(),
        "error_data": List<dynamic>.from(errorData.map((x) => x)),
      };
}

class Errors {
  Errors({
    this.incorrectPassword,
    this.invalidUsername,
  });

  List<String> incorrectPassword;
  List<String> invalidUsername;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        incorrectPassword:
            json["incorrect_password"] == null ? null : List<String>.from(json["incorrect_password"].map((x) => x)),
        invalidUsername:
            json["invalid_username"] == null ? null : List<String>.from(json["invalid_username"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "incorrect_password": List<dynamic>.from(incorrectPassword.map((x) => x)),
        "invalid_username": List<dynamic>.from(invalidUsername.map((x) => x)),
      };
}
