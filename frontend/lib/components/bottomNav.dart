import 'package:flutter/material.dart';
//import 'package:spotted/home/home.dart';
import '../home/home_page.dart';

class AppBarWidget extends StatefulWidget {
  //final List<Widget> tabs;

  AppBarWidget({Key key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  int _selectedIndex = 0;

  final tabs = [
    Center(child: HomePage()),
    Center(child: Text("blah"),),
    Center(child: Text("My Post Coming Soon"),),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: tabs[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar( 
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('New Post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            title: Text('My Post'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index){
          setState((){
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}