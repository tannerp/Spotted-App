import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:spotted/models/models.dart';

class UserApiClient {
  final _baseUrl = 'http://ec2-52-40-149-180.us-west-2.compute.amazonaws.com';
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


Future<dynamic> fetchMyProfile(@required String token) async {
    //this url and token might have to updated with actual backend routes
     Map<String, String> arg = {
      'Authorization': "Bearer $token",
      "Content-type": "application/json"};

 
    final url = '$_baseUrl/api/v0/users/profile';

    final http.Response response = await this.httpClient.get(url, headers: arg);
  
    if (response.statusCode != 200) {
      throw new Exception('Authentication Error');
     }

    return jsonDecode(response.body);
  }

 
  Future<String> updateUser(@required String token, User user) async {
    final String firstName = user.firstName;
    final String lastName = user.lastName;
    final String major = user.major;
    final String classStanding = user.classStanding;
    final String housing = user.housing;


    Map<String, String> arg = {
    'Authorization': "Bearer $token",
    "Content-type": "application/json"};
    // make POST request
    // use SSL to encrytp body

    final url = "$_baseUrl/api/v0/users/update_profile";

    http.Response response = await http.put(
      url,
      headers: arg,
      body: jsonEncode(
          <String, String>{
            'first_name': firstName, 
            'last_name': lastName, 
            'major': major, 
            'classStanding': classStanding, 
            'housing': housing
          }),
    );

    if (response.statusCode > 300) {
      throw new Exception('error updating user profile');
    }

    return ("Profile succesfully updated");
  }


}