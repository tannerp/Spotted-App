import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String token;
  final String firstName;
  final String lastName;

  const User({this.token, this.firstName, this.lastName});

  @override
  List <Object> get props => [token, firstName, lastName];

  static User fromJson(dynamic json){
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      token: json['token'],
    );
  }
  
  @override
  String toString() => '$firstName $lastName';
}