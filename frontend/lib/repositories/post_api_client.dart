import 'package:flutter/material.dart';

import 'dart:io';
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



  Future<List<Post>> fetchNewsfeed( @required String token) async {
    final url = '$_baseUrl/all';


    Map<String, String> arg = {
      'Authorization': "Bearer $token",
      "Content-type": "application/json"};
    

    final http.Response response = await this.httpClient.get(url, headers: arg);

    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
    }

    List<dynamic> list;

    try{
          list = await jsonDecode(response.body)["posts"].map((rawPost) {
            print(rawPost);

        return Post.fromJson(rawPost);
      }).toList();
    }catch(e){
      print(e);
    }

    return List<Post>.from(list);
  }
  
  

Future<List<Post>> toggleHelpPost(@required String token, @required String postID) async {
    // TODO
    // final url = '$_baseUrl/myposts';
    
    // final http.Response response = await this.httpClient.get(url);
    
    // List<dynamic> list;

    // if (response.statusCode != 200) {
    //   throw new Exception('Authentication Error');
    // }

    // try{
    //     list = await jsonDecode(response.body)["posts"].map((rawPost) {
    //     //    print(rawPost);
    //       return Post.fromJson(rawPost);
    //   }).toList();
    
    // }catch(e){
    //   print(e);
    // }
    // return List<Post>.from(list);
  }



Future<List<Post>> fetchMyPosts(@required String token) async {
    final url = '$_baseUrl/myposts';

    final Map<String, String> arg = {
      "Authorization": "Bearer $token",
      "Content-type": "application/json"};
    
    print(token);

    final http.Response response = await this.httpClient.get(url, headers: arg);
    
    List<dynamic> list;

    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
    }
    print(response.body);

    try{
        list = await jsonDecode(response.body)["posts"].map((rawPost) {
        //    print(rawPost);
          return Post.fromJson(rawPost);
      }).toList();
    
    }catch(e){
      print(e);
    }
    return List<Post>.from(list);
  }



  Future<String> createPost(@required String token, Post post) async {
    final String title = post.title;
    final String body = post.body;

    Map<String, String> arg = {
      'Authorization': "Bearer $token",
      "Content-type": "application/json"};
    
    final url = _baseUrl + "/newpost";

    http.Response response = await http.post(
      url,
      headers: arg,
      body: jsonEncode(
          <String, String>{'title': title, 'content': body}),
    );

    if (response.statusCode > 300) {
      throw new Exception('error getting posts');
    }

    return ("post succesful");
  }

}