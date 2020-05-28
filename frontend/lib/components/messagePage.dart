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
              print("logout");
            }),
      ),
      body: Text("Message here"),
    );
  }
}
