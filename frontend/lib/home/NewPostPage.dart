import 'package:flutter/material.dart';

// BloC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/models/post.dart';
import 'package:spotted/post/bloc.dart';

// NOTE can start with creating the UI. We will wire it up later

/*class NewPost extends StatelessWidget {

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
        
        return Scaffold(
      appBar: AppBar(title: Text("New Post")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             TextField(),
             TextField(),
              SizedBox(height: 100),
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  print("Button pressed");
                  
                },
              )
            ],
          ),
        ),
      ),
    );

     
      }
      return Center(
          child: CircularProgressIndicator(),
        );
      
    });
}

}*/



class NewPost extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
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
            builder: (context, state) {
              if (state is PostEmpty){
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
              }
            },
          ),
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
        onSubmitted: (value) => submitPost(context, new Post(body: value, title: value)),
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