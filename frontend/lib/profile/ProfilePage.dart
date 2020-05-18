import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotted/post/bloc.dart';
import 'package:spotted/components/postTile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostEmpty) {
        BlocProvider.of<PostBloc>(context).add(FetchPost());
      }

      if (state is PostError) {
        return Center(
          child: Text('failed to fetch profile'),
        );
      }

      if (state is PostLoaded) {
        return Text("Profile Page");
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
