
import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:spotted/models/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class FetchPost extends PostEvent {
  const FetchPost();

  @override
  List<Object> get props => [];
}

class FetchNewsfeed extends PostEvent {
  const FetchNewsfeed();

  @override
  List<Object> get props => [];
}

class FetchMyPosts extends PostEvent {
  const FetchMyPosts();

  @override
  List<Object> get props => [];
}

class SavePost extends PostEvent {
  final Post post;
  const SavePost(this.post);
  
  @override
  List<Object> get props => [post];
}

class CreatePost extends PostEvent {
  const CreatePost();
  
  @override
  List<Object> get props => [];
}