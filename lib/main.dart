import 'package:flutter/material.dart';
import 'package:flutter_auth_form/forms/auth/auth_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
            body: Center(
      child: AuthForm(),
    )));
  }
}
