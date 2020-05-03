import 'bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import './screens/createPost.dart';
import './screens/createProfile.dart';
import './screens/navBar.dart';
import './screens/reg_email.dart';
import './screens/reg_pass.dart';
import './screens/newsFeed.dart';
import 'bloc.dart';
import 'main_nav.dart';

void main() => runApp(SpottedApp());

class SpottedApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = DeepLinkBloc();
    return MaterialApp(
      title: 'Spotted App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => RegisterEmail(),
        '/register': (context) => RegisterEmail(),
        '/createProfile': (context) => CreateProfileScreen(),
        '/createPost': (context) => CreatePostForm(),
        '/home': (context) => AppBarWidget(),
        '/newsFeed': (context) => NewsFeedWidget(),
      }
    );
        // title: 'Spotted',
        // theme: ThemeData(
        //     primarySwatch: Colors.blue,
        //     textTheme: TextTheme(
        //       title: TextStyle(
        //         fontWeight: FontWeight.w300,
        //         color: Colors.blue,
        //         fontSize: 25.0,
        //       ),
        //     )),
        // home: Scaffold(
        //     body: Provider<DeepLinkBloc>(
        //         create: (context) => _bloc,
        //         dispose: (context, bloc) => bloc.dispose(),
        //         child: MainNav())));
  }
}
