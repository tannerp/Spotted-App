
import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:spotted/models/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class FetchPost extends PostEvent {
  final String postId;
  const FetchPost({this.postId});

  @override
  List<Object> get props => [];
}

class ToggleHelpPost extends PostEvent {
  final Post post;

  ToggleHelpPost(this.post);

  @override
  List<Object> get props => [post];
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

class DeletePost extends PostEvent {
  final String postId;
  const DeletePost({this.postId});
  
  @override
  List<Object> get props => [];
}