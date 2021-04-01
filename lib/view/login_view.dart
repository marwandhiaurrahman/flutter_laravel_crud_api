import 'package:flutter/material.dart';
import 'package:flutter_auth/Controller/api_controller.dart';
import 'package:flutter_auth/view/dashborad_view.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  ApiController apiController = new ApiController();
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Login Screen',
      emailValidator: (value) {
        if (!value.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      hideSignUpButton: true,
      hideForgotPasswordButton: true,
      passwordValidator: (value) {
        if (value.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        return apiController.loginUser(loginData);
      },
      onSignup: (loginData) {
        return null;
      },
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      },
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
        return apiController.recoverPassword(name);
        // Show new password dialog
      },
    );
  }
}
