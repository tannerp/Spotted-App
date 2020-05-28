import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:spotted/models/models.dart';
import 'package:spotted/post/bloc.dart';

class PostApiClient {
  final _baseUrl = 'http://localhost:8082/api/v0/posts';
  final http.Client httpClient;

  PostApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<dynamic>> fetchNewsfeed() async {
    final url = '$_baseUrl/all';

    final http.Response response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
    }
    final List<dynamic> list =
        await jsonDecode(response.body)["posts"].map((rawPost) {
      print(rawPost);
      return Post.fromJson(rawPost);
    }).toList();
    return list;
  }
  
  
  Future<List<dynamic>> fetchMyPosts() async {
    final url = '$_baseUrl/myposts';
    
    print("Fetching my posts");

    final http.Response response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
    }
    final List<dynamic> list =
        await jsonDecode(response.body)["posts"].map((rawPost) {
      print(rawPost);
      return Post.fromJson(rawPost);
    }).toList();
    return list;
  }

  Future<String> createPost(Post post) async {
    final String title = post.title;
    final String body = post.body;

    Map<String, String> arg = {"Content-type": "application/json"};
    // make POST request
    // use SSL to encrytp body

    final url = _baseUrl + "/newpost";

    http.Response response = await http.post(
      url,
      headers: arg,
      body: jsonEncode(
          <String, String>{'title': title, 'content': body, 'userId': ""}),
    );

    if (response.statusCode > 300) {
      throw new Exception('error getting posts');
    }

    return ("post succesful");
  }

}
