import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:spotted/models/models.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileEmpty extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override 
  List<Object> get props =>[message];
}


class ProfileSaving extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;

  const ProfileLoaded({@required this.user}) : assert(Post != null);

  @override
  List<Object> get props => [user];
}
