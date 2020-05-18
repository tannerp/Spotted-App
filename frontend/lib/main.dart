import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/components/bottomNav.dart';
import 'package:spotted/post/post_bloc.dart';
import 'package:spotted/repositories/post_api_client.dart';
import 'package:spotted/repositories/post_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:spotted/repositories/repository.dart';
import 'package:http/http.dart' as http;

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  final PostRepository postRepository = PostRepository(
    postApiClient: PostApiClient(
      httpClient: http.Client(),
      ),
  );

  runApp(App(
    userRepository: userRepository, 
    postRepository: postRepository)
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final PostRepository postRepository;
  

  App({Key key, @required this.userRepository, @required this.postRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => PostBloc(repository: postRepository),
          child: AppBarWidget(),
          ),
      ),
    );
  }
}
