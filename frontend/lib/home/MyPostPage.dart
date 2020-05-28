import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotted/post/bloc.dart';
import 'package:spotted/components/postTile.dart';
import 'package:spotted/home/MyPostDetailPage.dart';
import 'package:spotted/post/post_event.dart';

class MyPostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostEmpty) {
        BlocProvider.of<PostBloc>(context).add(FetchMyPosts());
      }

      if (state is PostError) {
        return Center(
          child: Text('Failed to fetch posts'),
        );
      }

      if (state is MyPostsReady) {
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

      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
