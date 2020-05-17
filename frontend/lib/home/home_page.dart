import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/components/bottomNav.dart';
import 'package:spotted/home/home.dart';

import 'package:spotted/post/bloc.dart';
import 'package:spotted/components/postTile.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
         if (state is PostEmpty) {
          BlocProvider.of<PostBloc>(context).add(FetchPost());
        }

        if (state is PostError) {
          return Center(
            child: Text('failed to fetch post'),
          );
        }

        if (state is PostLoaded) {
          return ListView(
              children: <Widget>[
                Card(child: PostTileWidget(
                  post: state.post,
                  userName: 'Lhakpa',
                  userImage: NetworkImage("https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                  postTime: TimeOfDay.now(),
                )),
              ],
              
              /*title: Text(state.post.title == null ? '2' : state.post.title),
              subtitle: Text(state.post.body == null ? '2' : state.post.body),
              dense: true,*/
            );
            /*
            ),*/
        }  
        return Center(
            child: CircularProgressIndicator(),
          );
        
      });
 } 
}
