import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/login/login_page.dart';
import 'package:spotted/post/post_bloc.dart';
import 'package:spotted/register/register_page.dart';

import 'package:spotted/repositories/post_api_client.dart';
import 'package:spotted/repositories/post_repository.dart';
// import 'package:spotted/repositories/post_api_client.dart';
import 'package:spotted/repositories/repository.dart';

import 'package:spotted/repositories/user_repository.dart';

import 'package:spotted/authentication/authentication.dart';
import 'package:spotted/splash/splash.dart';
import 'package:spotted/home/home.dart';
import 'package:spotted/home/new_post.dart';
import 'package:spotted/common/common.dart';

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

  runApp(
    BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted());
        },
        child: App(
            userRepository: userRepository, postRepository: postRepository)),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final PostRepository postRepository;

  App({Key key, @required this.userRepository, @required this.postRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            return MaterialApp(
                title: 'Spotted App',
                theme: ThemeData(
                  primarySwatch: Colors.teal,
                ),
                initialRoute: '/new_post',
                routes: {
                  '/': (context) => BlocProvider(
                        create: (context) =>
                            PostBloc(repository: postRepository),
                        child: LoginPage(userRepository: userRepository),
                      ),
                  '/login': (context) => BlocProvider(
                        create: (context) =>
                            PostBloc(repository: postRepository),
                        child: LoginPage(userRepository: userRepository),
                      ),
                  '/register': (context) => BlocProvider(
                        create: (context) =>
                            PostBloc(repository: postRepository),
                        child: RegisterPage(),
                      ),
                      //  TODO Remove when merge new post brand
                  '/new_post': (context) => BlocProvider(
                        create: (context) =>
                            PostBloc(repository: postRepository),
                        child: NewPost(),
                      ),
                });
          }
          if (state is AuthenticationAuthenticated) {
            // return LoginPage(userRepository: userRepository);
            return BlocProvider(
              create: (context) => PostBloc(repository: postRepository),
              child: HomePage(),
            );
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
    );
  }
}
