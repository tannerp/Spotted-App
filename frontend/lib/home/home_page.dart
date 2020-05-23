import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotted/post/bloc.dart';
import 'package:spotted/components/postTile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostEmpty) {
        BlocProvider.of<PostBloc>(context).add(FetchNewsfeed());
      }

      if (state is PostError) {
        return Center(
          child: Text('failed to fetch post'),
        );
      }

      if (state is NewsfeedReady) {
        return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new Card(
                  child: PostTileWidget(
                post: state.posts[index],
                userName: 'Lhakpa',
                userImage: NetworkImage(
                    "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                postTime: TimeOfDay.now(),
              ));
            });
      }

      if (state is PostLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
