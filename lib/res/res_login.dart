// To parse this JSON data, do
//
//     final resLogin = resLoginFromJson(jsonString);

import 'dart:convert';

ResLogin resLoginFromJson(String str) => ResLogin.fromJson(json.decode(str));

String resLoginToJson(ResLogin data) => json.encode(data.toJson());

class ResLogin {
  ResLogin({
    this.message,
    this.status,
    this.user,
  });

  String? message;
  int? status;
  User? user;

  factory ResLogin.fromJson(Map<String, dynamic> json) => ResLogin(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "user": user == null ? null : user!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.fullname,
    this.username,
    this.email,
    this.password,
    this.tglDaftar,
  });

  String? id;
  String? fullname;
  String? username;
  String? email;
  String? password;
  DateTime? tglDaftar;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    fullname: json["fullname"] == null ? null : json["fullname"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    tglDaftar: json["tgl_daftar"] == null ? null : DateTime.parse(json["tgl_daftar"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fullname": fullname == null ? null : fullname,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "tgl_daftar": tglDaftar == null ? null : tglDaftar!.toIso8601String(),
  };
}
