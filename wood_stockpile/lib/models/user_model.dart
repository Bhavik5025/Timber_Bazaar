// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String email;
    String mobileNumber;
    String password;
    String type;
    String username;

    UserModel({
        required this.email,
        required this.mobileNumber,
        required this.password,
        required this.type,
        required this.username,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        mobileNumber: json["mobile_number"],
        password: json["password"],
        type: json["type"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "mobile_number": mobileNumber,
        "password": password,
        "type": type,
        "username": username,
    };
}
