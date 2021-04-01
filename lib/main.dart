import 'package:flutter/material.dart';
import 'package:flutter_auth/view/dashborad_view.dart';
import 'package:flutter_auth/view/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> loadFromFuture() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('Token Start $value');
    if (value == 0) {
      return Future.value(new LoginScreen());
    }
    if (value != 0) {
      return Future.value(new DashboardScreen());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        loadingText: Text('asdasd'),
        seconds: 3,
        // navigateAfterSeconds: new LoginScreen(),
        navigateAfterFuture: loadFromFuture(),
        title: new Text(
          'Welcome In SplashScreen',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        // image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.blue);
  }
}
