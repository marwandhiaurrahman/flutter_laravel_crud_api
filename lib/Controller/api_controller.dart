import 'package:flutter/scheduler.dart';
import 'package:flutter_auth/model/product.dart';
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

  Future<String> recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  Future<List<Product>> listProduct() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token') ?? 0;

    String myUrl = "$serverUrl/products/";
    final response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }).timeout(Duration(seconds: 30));
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print(json.decode(response.body)['data']);
      return productFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Product> showProduct(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token') ?? 0;

    String myUrl = "$serverUrl/products/$id";
    final response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }).timeout(Duration(seconds: 30));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data']);
      return Product.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load album');
    }
  }

  void addProduct(String name, String detail) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.get(key) ?? 0;

      String myUrl = "$serverUrl/products";
      http.post(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      }, body: {
        "name": "$name",
        "detail": "$detail"
      }).then((response) {
        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');
      }).timeout(Duration(seconds: 30));
    } catch (e) {
      print(e);
    }
  }

  void deleteData(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.get(key) ?? 0;

      String myUrl = "$serverUrl/products/$id";
      http.delete(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      }).then((response) {
        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');
      }).timeout(Duration(seconds: 30));
    } catch (e) {
      print(e);
    }
  }

  void updateProduct(int id, String name, String detail) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.get(key) ?? 0;

      String myUrl = "$serverUrl/products/$id";
      http.put(Uri.parse(myUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
      }, body: {
        "name": "$name",
        "detail": "$detail",
      }).then((response) {
        print('Response status : ${response.statusCode}');
        print('Response body : ${response.body}');
      }).timeout(Duration(seconds: 30));
    } catch (e) {
      print(e);
    }
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
