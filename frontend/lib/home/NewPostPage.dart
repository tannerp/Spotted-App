import 'package:flutter/material.dart';

// BloC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/models/post.dart';
import 'package:spotted/post/bloc.dart';

class NewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SizedBox(
          child: Card(
            child: CreatePostForm(),
          ),
        ),
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


class CreatePostForm extends StatefulWidget {
  @override
  _CreatePostFormState createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {

  String _title ;
  String _content;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Title'
      ),
      maxLength: 30,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _title = value;
      },
    )

    );
  }
  
  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.all(8.0),
      //padding: EdgeInsets.only(bottom: 40.0),
      child:TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Content',
      ),
      maxLength: 200,
      maxLines: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Post Body is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _content= value;
      },
    )
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTitle(),
              _buildContent(),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  'post',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();
                  print(_title);
                  print(_content);
                  submitPost(context, new Post(body: _title, title: _content));
                  Navigator.pushNamed(context, '/home');                     
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void submitPost(BuildContext context, Post post) {
    final bloc = BlocProvider.of<PostBloc>(context);
    bloc.add(SavePost(post));
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
