import 'dart:async';

import 'package:meta/meta.dart';
import 'package:spotted/profile/profile_event.dart';
import 'package:spotted/repositories/user_api_client.dart';
import 'package:spotted/models/models.dart';

class UserRepository {
  User user;
  UserApiClient client;

  UserRepository({@required this.client}) : assert (client != null);
  
  Future<String> authenticate({
    @required String email,
    @required String password,
   }) async {
    final  json_rspn = await client.authenticate(email, password);
    this.user = User.fromJson(json_rspn);
    // fetch api
    return this.user.token;
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

  Future<User> fetchUserProfile() async {
    final User userProfile = await client.fetchUserProfile(user.token, user.userID);
    // return postApiClient .fetchNewsfeed();
    return userProfile;
  }

  Future<String> updateUser(User user) async {
    return await client.updateUser(user.token, user);
  }

}
