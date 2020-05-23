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


  Future<dynamic> authenticate(String email, String pass) async {
    // final String title = post.title;
    // final String body = post.body;
    Map<String, String> arg = {"Content-type": "application/json"};
    final url = "$_baseUrl/api/v0/users/auth/login";

    final Map<String, String> json = {"email": email, "password": pass}; 

    final http.Response response = await this.httpClient.post(url, headers: arg, body: jsonEncode(json));
 

    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
    }

    return jsonDecode(response.body);
  }
}