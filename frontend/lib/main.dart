import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Spotted App',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => VerifyScreen(),
//         '/register': (context) => RegisterApp()
//       }
//     );
//   }
// }

import 'nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';

void main() => runApp(PocApp());

class PocApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = DeepLinkBloc();
    return MaterialApp(
        title: 'Flutter and Deep Linsk PoC',
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
                child: Nav())));
  }
}
