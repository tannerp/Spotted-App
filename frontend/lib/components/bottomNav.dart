import 'package:flutter/material.dart';
import 'package:spotted/components/messagePage.dart';
import '../home/home_page.dart';
import '../home/MyPostPage.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({Key key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  int _selectedIndex = 0;

  final tabs = [
    Center(
      child: Text("New Post Page"),
    ),
    Center(child: HomePage()),
    Center(
      child: MyPostsPage()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seattle Pacific University'),
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print("Menu");
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.message),
              onPressed: () =>{
                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageApp()))})
        ],
      ),
      body: Center(
        child: tabs[_selectedIndex],
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
