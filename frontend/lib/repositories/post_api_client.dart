import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:spotted/models/models.dart';
import 'package:spotted/post/bloc.dart';

class PostApiClient {
  final _baseUrl = 'http://ec2-52-40-149-180.us-west-2.compute.amazonaws.com/api/v0/posts';
  final http.Client httpClient;

  PostApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Post>> fetchNewsfeed(@required String token) async {
    final url = '$_baseUrl/all';

    Map<String, String> arg = {
      'Authorization': "Bearer $token",
      "Content-type": "application/json"
    };

    final http.Response response = await this.httpClient.get(url, headers: arg);

    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
    }

    List<dynamic> list;

    try {
      list = await jsonDecode(response.body)["posts"].map((rawPost) {
        // print(rawPost);

        return Post.fromJson(rawPost);
      }).toList();
    } catch (e) {
      print(e);
    }

    return List<Post>.from(list);
  }

  Future<bool> toggleHelpPost(String token, Post post) async {
    final url = '$_baseUrl/toggle_help_post';

    print("Post api client fetching");
    print(post);

    final http.Response response = await this.httpClient.put(url);

    Map<String, String> arg = {
      'Authorization': "Bearer $token",
      "Content-type": "application/json"
    };

      dynamic rsp = await http.put(
      url,
      headers: arg,
      body: jsonEncode(<String, String>{
        'postID': post.id.toString(),
      }),
    );

    print(rsp);

    if (response.statusCode > 300) {
      throw new Exception('Error Toggling Help Post');
    }

    return (true);
  }

  Future<List<Post>> fetchMyPosts(@required String token) async {
    final url = '$_baseUrl/myposts';

    final Map<String, String> arg = {
      "Authorization": "Bearer $token",
      "Content-type": "application/json"
    };

    print(token);

    final http.Response response = await this.httpClient.get(url, headers: arg);

    List<dynamic> list;

    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
    }
    print(response.body);

    try {
      list = await jsonDecode(response.body)["posts"].map((rawPost) {
        //    print(rawPost);
        return Post.fromJson(rawPost);
      }).toList();
    } catch (e) {
      print(e);
    }
    return List<Post>.from(list);
  }

  Future<String> createPost(@required String token, Post post) async {
    final String title = post.title;
    final String body = post.body;

    Map<String, String> arg = {
      'Authorization': "Bearer $token",
      "Content-type": "application/json"
    };

    final url = _baseUrl + "/newpost";

    http.Response response = await http.post(
      url,
      headers: arg,
      body: jsonEncode(<String, String>{'title': title, 'content': body}),
    );

    if (response.statusCode > 300) {
      throw new Exception('error getting posts');
    }

    return ("post succesful");
  }
}
