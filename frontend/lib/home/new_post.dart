import 'package:flutter/material.dart';

// BloC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/post/bloc.dart';

// NOTE can start with creating the UI. We will wire it up later

class HomePage extends StatelessWidget {

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
        
        return Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'username'),
                  // controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  // controller: _passwordController,
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed: (){ print("Button Pressed");},
                  child: Text('Submit'),
                ),         
              ],
            ),
          );

     
      }
      return Center(
          child: CircularProgressIndicator(),
        );
      
    });
}

}
