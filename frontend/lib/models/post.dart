import 'package:equatable/equatable.dart';

class Post extends Equatable{
  final id;
  final String title;
  final String body;

  const Post({this.id, this.title, this.body});

  @override
  List <Object> get props => [id, title, body];

  // static Post fromJson(dynamic json) {
  factory Post.fromJson(Map<String,dynamic> json) {

    print("FromJson");
    return Post(
      id: json['id']??"",
      title: json['title']?? "",
      body: json['content'],
    );
  }
  
  @override
  String toString() => 'Post {id: $id $title}';
}