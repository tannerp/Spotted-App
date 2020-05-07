import 'package:equatable/equatable.dart';

class Post extends Equatable{
  final id;
  final String title;
  final String body;

  const Post({this.id, this.title, this.body});

  @override
  List <Object> get props => [id, title, body];

  static Post fromJson(dynamic json){
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
  
  @override
  String toString() => 'Post {id: $id}';
}