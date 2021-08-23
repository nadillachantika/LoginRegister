import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loginregist_ci/repository/regist_repo.dart';
import 'package:loginregist_ci/res/res_register.dart';
import 'package:loginregist_ci/ui/home_screen.dart';
import 'package:loginregist_ci/ui/login_page.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();

  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  Future<ResRegister?> registerAccount(
      String email, String fullname, String password, String username) async {
    setState(() {
      isLoading = true;
    });

    ResRegister res =
        await registRepo.registAccount(username, email, password, fullname);
    if (res.status == 200) {
      setState(() {
        log('data ${res.status}');
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal Register')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _keyForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.blue),
                        borderRadius: BorderRadius.circular(100)),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: username,
                validator: (val) {
                  return val!.isEmpty ? "Tidak boleh kosong" : null;
                },
                decoration: InputDecoration(
                    hintText: 'Input Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: email,
                validator: (val) {
                  return val!.isEmpty ? "Tidak boleh kosong" : null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Input Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: fullname,
                validator: (val) {
                  return val!.isEmpty ? "Tidak boleh kosong" : null;
                },
                decoration: InputDecoration(
                    hintText: 'Input Fullname',
                    prefixIcon: Icon(Icons.card_membership),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: password,
                validator: (val) {
                  return val!.isEmpty ? "Tidak boleh kosong" : null;
                },
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 16,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          registerAccount(email.text, fullname.text,
                              password.text, username.text);
                          Route route =
                          MaterialPageRoute(builder: (context) => LoginPage());
                          Navigator.push(context, route);
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              SizedBox(
                height: 8,
              ),
              new GestureDetector(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => LoginPage());
                    Navigator.push(context, route);
                  },
                  child: Text(
                    'Sudah punya akun? silahkan Login',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
