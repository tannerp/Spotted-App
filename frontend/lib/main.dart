import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';
import 'main_nav.dart';

void main() => runApp(SpottedApp());


class SpottedApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = DeepLinkBloc();
    return MaterialApp(
// <<<<<<< HEAD
//       title: 'Spotted App',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => VerifyScreen(),
//         '/register': (context) => RegisterScreen(),
//         '/createProfile': (context) => CreateProfileScreen(),
//         '/createPost': (context) => CreatePostForm(),
//         '/home': (context) => AppBarWidget(),
//         '/newsFeed': (context) => NewsFeedWidget(),
//       }
//     );
// =======
        title: 'Spotted',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              title: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.blue,
                fontSize: 25.0,
              ),
            )),
        home: Scaffold(
            body: Provider<DeepLinkBloc>(
                create: (context) => _bloc,
                dispose: (context, bloc) => bloc.dispose(),
                child: MainNav())));
  }
}
