import 'package:flutter/material.dart';
import 'package:frontend/screens/verifyEmail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coding with Curry',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: VerifyApp(),
    );
  }
}