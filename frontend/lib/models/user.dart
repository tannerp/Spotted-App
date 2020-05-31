import 'package:equatable/equatable.dart';

class User extends Equatable{
  final dynamic userID;
  final String email;
  final String firstName;
  final String lastName;
  final String major;
  final String classStanding;
  final String housing;

  const User({this.email, this.userID, this.firstName, this.lastName, this.major, this.classStanding, this.housing});

  

  @override
  List <Object> get props => [email, firstName, lastName, major, classStanding, housing];

  static User fromJson(dynamic json){
  print("from json");
  print(json);
  if(json == null) return json;
    
  return new User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      userID: json['userID'],
      major: json['major'],
      classStanding: json['classStanding'],
      housing: json['housing'],
    );
  }
  
  String toString() => '$firstName $lastName';
}