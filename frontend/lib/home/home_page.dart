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
          child: Text('Failed to fetch post'),
        );
      }

      if (state is NewsfeedReady) {
        if (state.posts == null) return Container(child:Center(child: Text("Empty"),));
        return Center(
            child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new Card(
                    child: PostTileWidget(
                    post: state.posts[index],
                    userImage: NetworkImage(
                        "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    onPressed: ()=> onHelpPress(state.posts[index].id),
                  
                  )
                  );
                }));
      }

      if (state is PostLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else{
        return Container(child:Center(child: Text("Empty"),));
      }
    });
  }
}


void onHelpPress(int postID){
  print("On help button pressed");
  
}