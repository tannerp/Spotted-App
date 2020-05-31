import 'package:equatable/equatable.dart';

class Post extends Equatable{
  final int id;
  final String userID;
  final String title;
  final String body;

  const Post({this.id, this.userID, this.title, this.body});

  @override
  List <Object> get props => [id, title, body];

  // static Post fromJson(dynamic json) {
  factory Post.fromJson(Map<String,dynamic> json) {
    return Post(
      id: json['id']?? "",
      userID: json['userID']?? "",
      title: json['title'] ?? "",
      body: json['content'] ?? "",
    );
  }
  
  @override
  String toString() => 'Post {id: $id $title}';
}