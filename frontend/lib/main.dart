import 'package:flutter/material.dart';
import 'package:frontend/screens/verifyEmail.dart';
import 'package:frontend/screens/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotted App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => VerifyScreen(),
        '/register': (context) => RegisterApp()
      }
    );
  }
}

