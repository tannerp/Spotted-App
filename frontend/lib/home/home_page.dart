import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotted/post/bloc.dart';

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
        return ListTile (
          title: Text(state.post.title == null ? '2' : state.post.title),
          subtitle: Text(state.post.body == null ? '2' : state.post.body),
          dense: true,
        );
      }
     
      
      return Center(
          child: CircularProgressIndicator(),
        );
      
    });
}

}
