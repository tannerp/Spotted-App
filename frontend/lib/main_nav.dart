import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/screens/reg_email.dart';
import 'package:frontend/screens/reg_pass.dart';

import 'bloc.dart';

class MainNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context);
    return StreamBuilder<String>(
      stream: _bloc.state,
      builder: (context, snapshot) {
        // if (!snapshot.hasData) {
        //   return Container(
        //       child: Center(
        //           child: Text('No deep link was used  ',
        //               style: Theme.of(context).textTheme.title)));
        // } else {
        //   return Container(
        //       child: Center(
        //           child: Padding(
        //               padding: EdgeInsets.all(20.0),
        //               child: Text('Redirected: ${snapshot.data}',
        //                   style: Theme.of(context).textTheme.title))));
        // }
         if (!snapshot.hasData) {
          return RegisterEmail();
        } else {
          return RegisterPassword();
      }
      }
    );
  }
}
