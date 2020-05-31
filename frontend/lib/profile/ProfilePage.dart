import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotted/profile/bloc.dart';
import 'package:spotted/profile/profile_state.dart';
import 'package:spotted/profile/profile_event.dart';
import 'package:spotted/components/myProfileTile.dart';

class ProfilePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(FetchProfile());

    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      
      if (state is ProfileEmpty) {
        BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
      }

      if (state is ProfileError) {
        return Center(
          child: Text('failed to fetch profile'),
        );
      }

      if (state is ProfileLoaded) {
        //fetchprofile method should return User
        return ProfilePageWidget('Lhakpa','sherpal@spu.edu');
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}


