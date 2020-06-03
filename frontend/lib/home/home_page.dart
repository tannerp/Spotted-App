import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotted/post/bloc.dart';
import 'package:spotted/components/postTile.dart';
import 'package:spotted/repositories/repository.dart';

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

        if (state.posts == null)
          return Container(
              child: Center(
            child: Text("Empty"),
          ));

        String _myemail =
            RepositoryProvider.of<UserRepository>(context).user.email;

        return Center(
            child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new Card(
                      child: PostTileWidget(
                    showedHelp:
                        state.posts[index].helps.indexOf(_myemail) > -1,
                    post: state.posts[index],
                    userImage: NetworkImage(
                        "https://s3.amazonaws.com/file.imleagues/Images/Schools/Uploaded/201807/20187181826335832fea530d3f43e68c1f65adb0d3c4cea3.jpg"),
                    onPressed: () => onHelpPress(state.posts[index].id),
                  ));
                }));
      }

      if (state is PostLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container(
            child: Center(
          child: Text("Empty"),
        ));
      }
    });
  }
}

void onHelpPress(int postID) {
  print("On help button pressed");
}
