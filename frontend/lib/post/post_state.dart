import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:spotted/models/models.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostEmpty extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final Post post;

  const PostLoaded({@required this.post}) : assert(Post != null);

  @override
  List<Object> get props => [Post];
}

class PostError extends PostState {}