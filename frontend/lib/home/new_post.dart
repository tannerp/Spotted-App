import 'package:flutter/material.dart';

// BloC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/post/bloc.dart';

// NOTE can start with creating the UI. We will wire it up later

class NewPost extends StatelessWidget {

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
      appBar: AppBar(title: Text("Verify Email")),
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

}
