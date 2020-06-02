import 'dart:async';

import 'package:meta/meta.dart';
import 'package:spotted/profile/profile_event.dart';
import 'package:spotted/repositories/user_api_client.dart';
import 'package:spotted/models/models.dart';

import 'package:cross_local_storage/cross_local_storage.dart';

class UserRepository {
  User user;
  String token;
  UserApiClient client;
  LocalStorageInterface _localStorage;

  UserRepository({@required this.client}) : assert (client != null){
    _initStorage();
  }

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

    this.persistToken(this.token);
    return this.token;
  }

  Future<void> deleteToken() async {
        return await   _localStorage?.clear();
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    final result =  await this._localStorage?.setString(
                    'token', token);
    
  }

  Future<bool> hasToken() async {
    final result = this._localStorage?.getString('token');

    if (result == null) return false;
    else{
      this.token = result;
      this.fetchMyProfile();
      return true;
    }
  }

  Future<User> fetchMyProfile() async {
    final user = await client.fetchMyProfile(this.token);
 
    try{
      final rsp =  User.fromJson(user);

      return rsp;

      }catch(e){
        throw new Exception('UserRepoError: Fetch my profile');
    }

  }

  Future<String> updateUser(User user) async {
    return await client.updateUser(this.token, user);
  }

  void  _initStorage() async {
    this._localStorage =  await LocalStorage.getInstance();
  }

}
