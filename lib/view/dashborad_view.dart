import 'package:flutter/material.dart';
import 'package:flutter_auth/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  String token;
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    setState(() {
      token = value;
    });
    print('read : $value');
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                logoutUser();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyApp()),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text(token),
      ),
    );
  }
}
