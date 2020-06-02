import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Post extends Equatable{
  final int id;
  final String userID;
  final String title;
  final String body;
  final String postedAt;

  const Post({this.id, this.userID, this.title, this.body, this.postedAt});

  @override
  List <Object> get props => [id, title, body];

  // static Post fromJson(dynamic json) {
  factory Post.fromJson(Map<String,dynamic> json) {
    return Post(
      id: json['id']?? "",
      userID: json['userID']?? "",
      title: json['content'] ?? "",
      body: json['title'] ?? "",
      postedAt: json['createdAt'] ?? "",
    );
  }
  
  @override
  String toString() => 'Post {id: $id $title}';
}