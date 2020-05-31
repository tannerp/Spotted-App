import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotted/components/bottomNav.dart';
import 'package:spotted/post/post_bloc.dart';
import 'package:spotted/register/register_page.dart';
// import 'package:spotted/

import 'package:spotted/repositories/post_api_client.dart';
import 'package:spotted/repositories/post_repository.dart';
import 'package:spotted/repositories/user_repository.dart';
import 'package:spotted/repositories/user_api_client.dart';

import 'package:spotted/repositories/repository.dart';

import 'package:spotted/authentication/authentication.dart';
import 'package:spotted/splash/splash.dart';
import 'package:spotted/home/home.dart';

import 'package:spotted/home/view_post.dart';
import 'package:spotted/common/common.dart';

import 'package:spotted/login/login_page.dart';
import 'package:spotted/profile/ProfilePage.dart';
import 'package:spotted/profile/bloc.dart';
// import 'package:spotted/common/common.dart';

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
  
  final http.Client httpClient = http.Client();


  final userRepository = UserRepository(
    client: UserApiClient(
      httpClient: httpClient,
    ),
  );

  final PostRepository postRepository = PostRepository(
    postApiClient: PostApiClient(
      httpClient: httpClient,
    ),userRepo: userRepository
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
  
  final PostBloc postBloc;

  App({Key key, @required this.userRepository, @required this.postRepository})
      : this.postBloc = new PostBloc(postRepo: postRepository, userRepo: userRepository), super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
      if (state is AuthenticationUnauthenticated) {
        return MaterialApp(
            title: 'Spotted App',
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            initialRoute: 'register',
            routes: {
              '/': (context) => LoginPage(userRepository: userRepository),
              '/login': (context) => LoginPage(userRepository: userRepository,),
              '/register': (context) => RegisterPage(),
            });
      }

      if (state is AuthenticationAuthenticated) {
        // return LoginPage(userRepository: userRepository);
        return BlocProvider(
            create: (context) => PostBloc(postRepo: postRepository, userRepo: userRepository),
            child: MaterialApp(
              initialRoute: '/', 
              routes: {
              '/': (context) => BlocProvider.value(value: BlocProvider.of<PostBloc>(context),
              child: SpottedApp()),
              '/home': (context) => BlocProvider.value(value: BlocProvider.of<PostBloc>(context),
              child: SpottedApp()),
              '/profile': (context) => BlocProvider.value(value: BlocProvider.of<PostBloc>(context),
              child: ProfilePage()),                  
            }));
      }

      if (state is AuthenticationLoading) {
            return Center(child: CircularProgressIndicator());
      }

      return SplashPage();
    }));
  }
}
