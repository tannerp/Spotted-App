//import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Card(
            child: NewsFeed(),
          ),
        ),
      ),
    );
  }
}


class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  Future <List<Post>>_getData() async {
    http.Response response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept": "application/json"
      }
    );
    
    var jsonData = json.decode(response.body);

    List<Post> posts = [];

    for (var p in jsonData){
      Post post = Post(p["title"], p["body"]);
      posts.add(post);
    }
    print(posts.length);
    return posts;

  }



  Widget postTemplate(data) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Column(
        children: <Widget>[
          Text(
            data[0],
          ),
          Text(
            data[1]),
        ],
      ),
    );
  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final String data = getData(1, "title").toString();
    //print(data);
    //_getData(1, "title");
    return Scaffold(
      appBar: AppBar(title: Text("NewsFeed")),
      body: 
      Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: FutureBuilder(
                  future: _getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading.."),                         
                        )
                      );   
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].content),
                        );
                      }
                    );
                  },
                ),
              ),
            ], 
          ),
        ),
      ),
    );
  }
}

/// A itemPost that contains data to display a Post.

class Post{
  final String title;
  final String content;

  Post(this.title, this.content);
}

