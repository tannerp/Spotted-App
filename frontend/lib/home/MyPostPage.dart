import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotted/post/bloc.dart';
import 'package:spotted/components/postTile.dart';
import 'package:spotted/home/MyPostDetailPage.dart';
import 'package:spotted/post/post_event.dart';

class MyPostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(listener: (context, state) {
      if (state is PostEmpty) {
        BlocProvider.of<PostBloc>(context).add(FetchMyPosts());
      };

      if (state is PostError) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('${state.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }, child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {    

      if (state is PostError) {
        return Center(
          child: Text('Failed to fetch posts'),
        );
      }

      if (state is MyPostsReady) {
        print("My Posts ReadY");
        print(state);
        if (state.my_posts == null) return Container();

        return ListView.builder(
            itemCount: state.my_posts.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Card(
                  child: PostTileWidget(
                post: state.my_posts[index],
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
      if (state is PostError) {
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
