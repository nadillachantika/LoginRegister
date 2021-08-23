
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:loginregist_ci/repository/login_repo.dart';
import 'package:loginregist_ci/res/res_login.dart';

import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  Future<ResLogin?> loginAccount(String email, String password) async{
    setState(() {
      isLoading = true;

    });
    ResLogin res= await loginRepo.loginAccount(email, password);
    if(res.status ==200){
      setState(() {
        log('data ${res.status}');
        Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal Login')));
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
                child: Container(
                    decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(100)
                  ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: Icon(Icons.person, size: 50,
                      color: Colors.blue,),
                    ),
                  ),
              ),

              TextFormField(
                controller: email,
                validator: (val){
                  return val!.isEmpty? "Tidak boleh kosong": null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Input Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              ),
              SizedBox(height: 16,),

              TextFormField(
                controller: password,
                validator: (val){
                  return val!.isEmpty ? "Tidak boleh kosong" :null;
                },
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              ),

              SizedBox(height: 16,),
              isLoading ? Center( child: CircularProgressIndicator(),):

              MaterialButton(
                color: Colors.blue,
                  onPressed: (){
                  if(_keyForm.currentState!.validate()){
                    loginAccount(email.text, password.text);
                  }
                  },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 8,),
              Text('Belum punya akun? silahkan register')

            ],

          ),
        ),
      ),
    );
  }
}
