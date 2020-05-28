import 'package:flutter/material.dart';

// BloC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/models/post.dart';
import 'package:spotted/post/bloc.dart';

class NewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child:  BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              if (state is PostEmpty) {
                return buildInitialInput();
                //BlocProvider.of<PostBloc>(context).add(FetchPost());
              } else if (state is PostLoading) {
                return buildLoading();
              } else if (state is PostLoaded) {
                return buildLoading();
              } else if (state is PostSaving) {
                return buildSaving();
              } else if (state is PostError) {
                return buildInitialInput();
              }else {
                return buildInitialInput();
              }

            },

        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: PostInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoaded() {
    return Center();
  }

  Widget buildSaving() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

// Todo, add one more textField
class PostInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) =>
            submitPost(context, new Post(body: value, title: value)),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "What's on your mind?",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.save),
        ),
      ),
    );
  }

  // Sumbit button method(add event to the Bloc)
  void submitPost(BuildContext context, Post post) {
    final bloc = BlocProvider.of<PostBloc>(context);
    bloc.add(SavePost(post));
  }
}
