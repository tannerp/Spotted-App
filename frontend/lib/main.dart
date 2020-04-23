import 'package:flutter/material.dart';
import 'package:frontend/screens/createProfile.dart';
import 'package:frontend/screens/verifyEmail.dart';
import 'package:frontend/screens/register.dart';
import 'package:frontend/screens/createPost.dart';
import 'package:frontend/screens/navBar.dart';
import 'package:frontend/screens/newsFeed.dart';

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
        '/register': (context) => RegisterScreen(),
        '/createProfile': (context) => CreateProfileScreen(),
        '/createPost': (context) => CreatePostForm(),
        '/home': (context) => AppBarWidget(),
        '/newsFeed': (context) => NewsFeedWidget(),
      }
    );
  }
}

