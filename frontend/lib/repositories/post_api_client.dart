import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:spotted/models/models.dart';

class PostApiClient {
  
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts/1';
  
  final http.Client httpClient;
  
  
  PostApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  
  Future<Post> fetchPost() async {
    final url = 'https://jsonplaceholder.typicode.com/posts/1';
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting posts');
    }

    final json = jsonDecode(response.body);
    return Post.fromJson(json);
  }

  Future<String> createPost(Post post) async {
    final String title = post.title;
    final String body = post.body;
    final url = "$_baseUrl/$title/$body";
    final response = await this.httpClient.post(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting posts');
    }

    return ("post succesful");
  }
}
