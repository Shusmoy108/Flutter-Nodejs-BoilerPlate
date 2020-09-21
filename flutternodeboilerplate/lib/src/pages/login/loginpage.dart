import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:blogapp/src/pages/home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:blogapp/src/api/userapiclass.dart';
import 'dart:convert';
const users = const {
  '01819648302': '12345',
  'hunter@gmail.com': 'hunter',
};
class LoginScreen extends StatefulWidget {
  @override
  LoginScreenForm createState() => LoginScreenForm();
}

class LoginScreenForm extends State<LoginScreen> {
  UserApi userApi= new UserApi();
  String password="",mobile="";
  bool login=true;
  @override
  Duration get loginTime => Duration(milliseconds: 2250);
  Future<String> _signup(LoginData data) {
    setState(() {
  mobile=data.name;
  password=data.password;
  login=false;
  });
  print('Name: ${data.name}, Password: ${data.password}');

  return Future.delayed(loginTime).then((_)async {
    var res= await userApi.addUser(data.name,data.password);
    print(res);
    print("resres");
    if(!res['success']){
      return res['error'];
    }
//      if (!users.containsKey(data.name)) {
//        return 'Mobile Number not exists';
//      }
//      if (users[data.name] != data.password) {
//        return 'Password does not match';
//      }
  return null;
  });
}
void apiTest(String name)async{
  var url = "http://10.0.2.2:5000/api/user";
  Map<String, String> headers = new Map();
  headers['Content-Type'] = 'application/json';
  var body = json.encode({
    "name": name,
  });

  var tokenResponse = await http.post(url, body: body, headers: headers);
  var userToken = jsonDecode(tokenResponse.body)['success'];
  print(userToken);
}
  Future<String> _login(LoginData data) {
    setState(() {
      mobile=data.name;
      password=data.password;
     login=true;
    });
    print('Name: ${data.name}, Password: ${data.password}');
    apiTest(data.name);
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Mobile number does not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }
  String emailValidator(String value){
    if(value.length<8){
      return "Invalid mobile number";
    }
  }
  _saveAuthData()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('auth', true);
    sp.setString("mobile", mobile);
  }
  Future _submit(){
 _saveAuthData();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Home("as");
        },
      ),
    );
  }
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: 'Blog Zone',
      //logo: 'images/logo.jpg',
      onLogin: _login,
      onSignup: _signup,
      emailValidator: emailValidator,
      onSubmitAnimationCompleted: _submit,
      onRecoverPassword: (_) => Future(null),
      messages: LoginMessages(
        usernameHint: 'Mobile Number',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'Create a new Account',
        forgotPasswordButton: 'Forgot Your Password',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
        'Please the mobile number of your account. We will send an OTP to your number for password change request.',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
      theme: LoginTheme(
        primaryColor: Colors.teal,
        accentColor: Colors.yellow,
        errorColor: Colors.deepOrange,
        titleStyle: TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: Colors.orange,
          shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.yellow,
        ),
        cardTheme: CardTheme(
          color: Colors.yellow.shade100,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.orange,
            color: Colors.white,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
//        buttonTheme: LoginButtonTheme(
//          splashColor: Colors.purple,
//          backgroundColor: Colors.pinkAccent,
//          highlightColor: Colors.lightGreen,
//          elevation: 9.0,
//          highlightElevation: 6.0,
//          shape: BeveledRectangleBorder(
//            borderRadius: BorderRadius.circular(10),
//          ),
//          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
//          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
//        ),
      ),



    );
  }
}