import 'dart:convert';

import 'package:http/http.dart';
import 'package:loginregist_ci/constant/constant.dart';
import 'package:loginregist_ci/res/res_login.dart';
import 'package:http/http.dart'as http;

class LoginRepo{

  Future<ResLogin> loginAccount(String email, String password) async{
    Response res = await http.post(Uri.parse(baseUrl+"loginUser"), body: {
      "email": email,
      "password": password

    });
    return ResLogin.fromJson(jsonDecode(res.body));
  }
}

LoginRepo loginRepo = LoginRepo();