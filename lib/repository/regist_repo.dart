
import 'dart:convert';
import 'package:http/http.dart';
import 'package:loginregist_ci/constant/constant.dart';
import 'package:loginregist_ci/res/res_register.dart';
import 'package:http/http.dart'as http;

class RegistRepo{

  Future<ResRegister> registAccount(String username,String email, String password,String fullname,) async{
    Response res = await http.post(Uri.parse(baseUrl+"registerUser"), body: {
      "username": username,
      "email":email,
      "password":password,
      "fullname":fullname
    });
    return ResRegister.fromJson(jsonDecode(res.body));

  }
}

RegistRepo registRepo = RegistRepo();