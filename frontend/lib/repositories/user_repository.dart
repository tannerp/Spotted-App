import 'dart:async';

import 'package:meta/meta.dart';
import 'package:spotted/profile/profile_event.dart';
import 'package:spotted/repositories/user_api_client.dart';
import 'package:spotted/models/models.dart';

class UserRepository {
  User user;
  String token;
  UserApiClient client;

  UserRepository({@required this.client}) : assert (client != null);
  
  Future<String> authenticate({
    @required String email,
    @required String password,
   }) async {
    final  json_rspn = await client.authenticate(email, password);
    
    this.token = json_rspn["token"];   
    this.user = User(
    email:json_rspn["user"]["email"],
    userID:json_rspn["user"]["userID"],
    firstName: json_rspn["user"]["firstName"],
    lastName: json_rspn["user"]["lastName"],
    major: json_rspn["user"]['major'],
    classStanding: json_rspn["user"]['classStanding'],
    housing: json_rspn["user"]['housing']);

    return this.token;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  Future<User> fetchMyProfile() async {
    final user = await client.fetchMyProfile(this.token);
    
    print("User repo");
    print(user);

    try{
      final rsp =  User.fromJson(user);

      // email: user["email"],
      // userID: user["userID"],
      // firstName: user["firstName"],
      // lastName: user["lastName"],
      // major: user['major'],
      // classStanding: user['classStanding'],
      // housing: user['housing']);
      
      print(rsp);
      return rsp;

      }catch(e){
        print("Error making user");
        print(e);
        throw new Exception('UserRepoError: Fetch my profile');
    }

  }

  Future<String> updateUser(User user) async {
    return await client.updateUser(this.token, user);
  }

}
