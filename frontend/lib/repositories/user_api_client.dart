// import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:spotted/models/models.dart';

class UserApiClient {
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


Future<User> fetchMyProfile(@required String token) async {
    final url = '$_baseUrl/';

    final http.Response response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
    }
    final User userProfile = User.fromJson(response.body);
    return userProfile;
  }


  Future<User> fetchUserProfile(@required String token, String userID) async {
    final url = '$_baseUrl/';

    final http.Response response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
    }
    final User userProfile = User.fromJson(response.body);
    return userProfile;
  }
  
 
  Future<String> updateUser(@required String token, User user) async {
    final String firstName = user.firstName;
    final String lastName = user.lastName;


    Map<String, String> arg = {"Content-type": "application/json"};
    // make POST request
    // use SSL to encrytp body

    final url = _baseUrl + "/newpost";

    http.Response response = await http.post(
      url,
      headers: arg,
      body: jsonEncode(
          <String, String>{'first_name': firstName, 'last_name': lastName}),
    );

    if (response.statusCode > 300) {
      throw new Exception('error updating user profile');
    }

    return ("profile succesfully updated");
  }


}