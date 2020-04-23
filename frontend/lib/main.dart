import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';
import 'poc.dart';

void main() => runApp(SpottedApp());


class SpottedApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = DeepLinkBloc();
    return MaterialApp(
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
