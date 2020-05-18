import 'package:flutter/material.dart';
import './bottomNav.dart';

class MessageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => AppBarWidget()));
            }),
      ),
      body: Text("Message here"),
    );
  }
}
