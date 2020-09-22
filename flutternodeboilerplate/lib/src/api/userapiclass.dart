import 'package:flutternodeboilerplate/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserApi {
  String ipiOSemu= 'http://localhost:5000/';
  String ipandroidemu= 'http://10.0.2.2:5000/';
  String ipRealdevice="http//:www.someserver.com";/// your server address
  Future addUser(String mobile, String password)async{
          var url = ipandroidemu+"api/user"; //For Adroid Emulator
          //var url= ipiOSemu+"api/user"; //For iOS Emulator
          //var url= ipRealdevice+"api/user";//For real server adresss
          Map<String, String> headers = new Map();
          headers['Content-Type'] = 'application/json';
          var body = json.encode({
            "mobile": mobile,
            "password":password
          });
          var response = await http.post(url, body: body, headers: headers);
          bool success = jsonDecode(response.body)['success'];
          if(success){
            var user=jsonDecode(response.body)['user'];
            User u = new User(user['mobile']);
            return {'success':true, 'mobile':u.mobile};
          }
          else{
            String error = jsonDecode(response.body)['error'];
            print(error);
            return {'success':false, 'error':error};
          }
  }
  Future login(String mobile, String password)async {
    var url = ipandroidemu + "api/login"; //For Adroid Emulator
    Map<String, String> headers = new Map();
    headers['Content-Type'] = 'application/json';
    var body = json.encode({
      "mobile": mobile,
      "password": password
    });
    var response = await http.post(url, body: body, headers: headers);
    bool success = jsonDecode(response.body)['success'];
    if (success) {
      var user = jsonDecode(response.body)['user'];
      User u = new User(user['mobile']);
      return {'success': true, 'mobile': u.mobile};
    }
    else {
      String error = jsonDecode(response.body)['error'];
      return {'success': false, 'error': error};
    }
  }
}