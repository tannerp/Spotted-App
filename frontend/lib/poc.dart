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
          if (!snapshot.hasData) {
            return RegEmail();
          } else {
            return RegPassword();
          }
        });
  }
}
