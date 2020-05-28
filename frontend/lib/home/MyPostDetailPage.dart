import 'package:flutter/material.dart';

class MyPostDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Post Detail Page"),
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              // print("My Post Detail Page");
              Navigator.pop(context);
            }),
      ),
      body: Text("Message here"),
    );
  }
}
