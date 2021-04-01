import 'package:flutter/scheduler.dart';
import 'package:flutter_auth/users.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiController {
  String serverUrl = "http://10.0.2.2:8000/api";
  var status;
  var token;

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 1);

  Future<String> loginUser(LoginData loginData) async {
    try {
      print('LoginScreen info');
      print('Name: ${loginData.name}');
      print('Password: ${loginData.password}');
      String myUrl = "$serverUrl/login";
      final response = await http.post(Uri.parse(myUrl), headers: {
        'Accept': 'application/json'
      }, body: {
        "email": '${loginData.name}',
        "password": "${loginData.password}"
      }).timeout(Duration(seconds: 30));
      status = response.body.contains('error');
      var data = json.decode(response.body);

      return Future(() {
        if (status) {
          print('data : ${data["error"]}');
          return 'Error : ${data["message"]}';
        }
        print('Data : ${data["data"]["token"]}');
        _save(data["data"]["token"]);
        return null;
      });
    } catch (e) {
      print('Error : $e');
      return 'Error : $e';
    }
  }

  loginData(LoginData loginData) async {
    String myUrl = serverUrl;
    final response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "email": '${loginData.name}',
      "password": "${loginData.password}"
    });

    status = response.body.contains('error');
    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  Future<String> recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
