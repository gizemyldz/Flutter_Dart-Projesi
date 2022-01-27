import 'package:flutter/material.dart';
import 'package:meditation_app_ui/screens/welcome/screen/login_signup.dart';

class LoginSignupUI extends StatelessWidget {
  const LoginSignupUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login Signup",
      home: LoginSignupScreen(),
    );
  }
}
