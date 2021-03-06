import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotted/profile/bloc.dart';
import 'package:spotted/profile/profile_state.dart';
import 'package:spotted/profile/profile_event.dart';
import 'package:spotted/components/myProfileTile.dart';
import 'package:spotted/models/user.dart';

class ProfilePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      
      if (state is ProfileEmpty) {
        BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
      }

      if (state is ProfileError) {
        return Center(
          child: Text('Error'),
        );
      }

      if (state is ProfileLoaded) {
        //fetchprofile method should return User
        
        return BlocProvider.value(
          value: BlocProvider.of<ProfileBloc>(context),
          child: ProfilePageWidget(
          state.user.firstName, 
          state.user.lastName, 
          state.user.email,
          state.user.major,
          state.user.classStanding,
          state.user.housing,
          () => saveUser(context, new User(
            userID: state.user.userID,
            firstName: state.user.firstName,
            lastName: state.user.lastName,
            major: state.user.major,
            classStanding: state.user.classStanding,
            housing: state.user.housing,
          )),
          ));
      }

      if (state is ProfileLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

void saveUser(BuildContext context, User user) {
    print("save function detected");
    BlocProvider.of<ProfileBloc>(context).add(SaveProfile(user));
}
