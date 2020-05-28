
import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:spotted/models/User.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class FetchProfile extends ProfileEvent {
  final String postId;
  const FetchProfile({this.postId});

  @override
  List<Object> get props => [];
}



class UpdateProfile extends ProfileEvent {
  const UpdateProfile();
  
  @override
  List<Object> get props => [];
}


// class FetchNewsfeed extends ProfileEvent {
//   const FetchNewsfeed();

//   @override
//   List<Object> get props => [];
// }

// class FetchMyPosts extends ProfileEvent {
//   const FetchMyPosts();

//   @override
//   List<Object> get props => [];
// }

// class SavePost extends ProfileEvent {
//   final User user;
//   const SavePost(this.user);
  
//   @override
//   List<Object> get props => [user];
// }

// class DeletePost extends ProfileEvent {
//   final String postId;
//   const DeletePost({this.postId});
  
//   @override
//   List<Object> get props => [];
// }