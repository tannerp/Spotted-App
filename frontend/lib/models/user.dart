import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String token;
  final String userID;
  final String firstName;
  final String lastName;
  final String major;
  final String classStanding;
  final String housing;

  const User({this.token, this.userID, this.firstName, this.lastName, this.major, this.classStanding, this.housing});

  @override
  List <Object> get props => [token, firstName, lastName, major, classStanding, housing];

  static User fromJson(dynamic json){
    return new User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      token: json['token'],
      userID: json['userID'],
      major: json['major'],
      classStanding: json['classStanding'],
      housing: json['housing'],
    );
  }
  
  @override
  String toString() => '$firstName $lastName';
}