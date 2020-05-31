import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotted/components/myProfileTile.dart';
import 'package:spotted/profile/profile_bloc.dart';
import 'package:spotted/profile/profile_event.dart';
import 'package:spotted/profile/profile_state.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(listener: (context, state) {
      if (state is ProfileEmpty) {
        BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
      }

      if (state is ProfileError) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('${state.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }, 
    child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {    

      if (state is ProfileError) {
        return Center(
          child: Text('Failed to fetch profile information'),
        );
      }

      if (state is ProfileLoaded) {
        print("Profile information loaded");
        print(state);
        if (state.user == null) return Container();

        return ProfilePageWidget(state.user.firstName, state.user.lastName);
      }

      if (state is ProfileLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ProfileError) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('${state.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }

      print(state);
      return Container();
    }));
  }
}
