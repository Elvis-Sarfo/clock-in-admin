import 'package:clock_in_student/screens/auth/login/components/login_body.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: LoginBody()));
  }
}
