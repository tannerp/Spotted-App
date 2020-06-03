import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/home/home.dart';

import 'package:spotted/post/bloc.dart';
import 'package:spotted/components/postTile.dart';
import 'package:spotted/home/MyPostDetailPage.dart';
import 'package:spotted/post/post_event.dart';
import 'package:spotted/models/models.dart';
import 'package:spotted/repositories/repository.dart';

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
        if (state.my_posts == null) return Container(child:Center(child:Text("Empty")));
        
        String _myemail = RepositoryProvider.of<UserRepository>(context).user.email;

        print("EMAIL $_myemail");
        
        return ListView.builder(
            itemCount: state.my_posts.length,
            itemBuilder: (BuildContext ctxt, int index) {

              return Card(
                  child: PostTileWidget(
                showedHelp: state.my_posts[index].helps.indexOf(_myemail) > -1,
                post: state.my_posts[index],
                userImage: NetworkImage(
                    "https://s3.amazonaws.com/file.imleagues/Images/Schools/Uploaded/201807/20187181826335832fea530d3f43e68c1f65adb0d3c4cea3.jpg"),
              onPressed: ()=>onHelpPress(ctxt, state.my_posts[index]),
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

        return Container(child:Center(child: Text("Empty"),));    }));
  }
}

void onHelpPress(BuildContext context, Post post){
  BlocProvider.of<PostBloc>(context).add(ToggleHelpPost(post));
  
}