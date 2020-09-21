import 'package:blogapp/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserApi {
  String ipiOSemu= 'http://localhost:5000/';
  String ipandroidemu= 'http://10.0.2.2:5000/';
  String ipRealdevice="";
  Future addUser(String mobile, String password)async{
    var url = "http://10.0.2.2:5000/api/user";
    Map<String, String> headers = new Map();
    headers['Content-Type'] = 'application/json';
    var body = json.encode({
      "mobile": mobile,
      "password":password
    });
    var response = await http.post(url, body: body, headers: headers);
    print(response.body.toString());
    bool userToken = jsonDecode(response.body)['success'];
    if(userToken){
      return {'success':true};
    }
    else{
      String error = jsonDecode(response.body)['error'];
      print(error);
      return {'success':false, 'error':error};
    }
  }

}