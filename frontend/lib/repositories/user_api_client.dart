// import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:spotted/models/models.dart';

class UserApiClient {
  // final _baseUrl = 'https://jsonplaceholder.typicode.com/posts/1';
  final _baseUrl = 'http://localhost:8082';
  final http.Client httpClient;

  UserApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  // Future<Post> fetchPost() async {
  //   final url = 'https://jsonplaceholder.typicode.com/posts/1';
  //   final response = await this.httpClient.get(url);

  //   if (response.statusCode != 200) {
  //     throw new Exception('error getting posts');
  //   }

  //   final json = jsonDecode(response.body);
  //   return Post.fromJson(json);
  // }

  Future<String> authenticate(String email, String pass) async {
    // final String title = post.title;
    // final String body = post.body;
    final url = "$_baseUrl/login";

    final response = await this.httpClient.post(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting posts');
    }

    return jsonDecode(response.body);
    
  }
}