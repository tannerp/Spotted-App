import 'package:flutter/material.dart';
// BloC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/models/post.dart';
import 'package:spotted/post/bloc.dart';

class ViewPost extends StatelessWidget {
  final String postId;
  ViewPost({Key key, @required this.postId}) : super(key: key);
  @override 
  Widget build(BuildContext context) {
    BlocProvider.of<PostBloc>(context).add(FetchPost(postId:postId));
    return Scaffold(
      appBar: AppBar(
        title: Text("View My Post"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:16),
        alignment: Alignment.center,
        child: BlocListener <PostBloc, PostState> (
          listener: (context,state) {
            if (state is PostError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<PostBloc, PostState>(
            builder:(context, state) {
              if (state is PostLoading){
                return buildLoading();
              } else if (state is PostLoaded ) {
                return buildLoaded(context,state.post);
              }
            },
          ),
        ),
      ),
    );
  }

   Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildLoaded(BuildContext context,Post post) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          // Display the post title 
          post.title,
          style: TextStyle(fontSize: 13),
        ),
    
        Text(
          // Display the post content
          post.body,
          style: TextStyle(fontSize: 15), 
        ),

        RaisedButton(
          child: Text('Delete my post'),
          color: Colors.lightBlue[100],
          onPressed: () {
            BlocProvider.of<PostBloc>(context).add(DeletePost(postId:postId));
          }
          )
      ]
    );
  }
}