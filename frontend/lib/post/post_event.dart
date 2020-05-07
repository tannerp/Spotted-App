import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class FetchPost extends PostEvent {
  const FetchPost();

  @override
  List<Object> get props => [];
}

class CreatePost extends PostEvent {
  const CreatePost();

  @override
  List<Object> get props => [];
}