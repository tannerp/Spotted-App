import 'package:flutter/material.dart';
import 'package:spotted/components/messagePage.dart';
import 'package:spotted/home/NewPostPage.dart';
import '../home/home_page.dart';
import '../home/MyPostPage.dart';
import '../profile/ProfilePage.dart';

import 'package:spotted/post/post_bloc.dart';
import 'package:spotted/post/post_state.dart';
import 'package:spotted/post/post_event.dart';
import 'package:spotted/repositories/post_repository.dart';
import 'package:spotted/repositories/user_repository.dart';
import 'package:spotted/repositories/user_api_client.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SpottedApp extends StatefulWidget {
  final PostRepository postRepository;
  UserRepository userRepository;
  List<Widget> tabs;

  SpottedApp({Key key, @required this.postRepository})
      : assert(postRepository != null),
        super(key: key);
  @override
  _SpottedApp createState() => _SpottedApp(repo: postRepository);
}

class _SpottedApp extends State<SpottedApp> {
  int _selectedIndex = 1;
  PostBloc postBloc;
  PostRepository repo;
  List<Widget> _tabs;

  _SpottedApp({@required this.repo}) {
    this.postBloc = new PostBloc(repository: repo);
  }

  @override
  Widget build(BuildContext context) {
    _tabs = [
      BlocProvider(
        create: (BuildContext context) =>  PostBloc(repository: repo),
        child: NewPost(),
      ),
      BlocProvider(
        create: (BuildContext context) =>  PostBloc(repository: repo),
        child: HomePage(),
      ),
      // BlocProvider.value(
      //   value: BlocProvider.of<PostBloc>(context),
      //   child: HomePage(),
      // ),
      Center(child: MyPostsPage()),
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seattle Pacific University'),
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () => {
                  print('profile pressed'),
                  Navigator.pushNamed(context, "/profile")
                }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.message),
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MessageApp()))
                  })
        ],
      ),
      body: Center(
        child: _tabs[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('New Post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            title: Text('My Post'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
