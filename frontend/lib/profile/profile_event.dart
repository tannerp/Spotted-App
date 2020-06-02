
import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:spotted/models/models.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}


class FetchProfile extends ProfileEvent {
  final User user;
  const FetchProfile({this.user});

  @override
  List<Object> get props => [];
}

class UpdateProfile extends ProfileEvent {
  const UpdateProfile();
  
  @override
  List<Object> get props => [];
}

class SaveProfile extends ProfileEvent {
  final User user;
  const SaveProfile(this.user);
  
  @override
  List<Object> get props => [user];
}