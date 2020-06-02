import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:spotted/repositories/repository.dart';
import 'package:spotted/profile/profile_event.dart';
import 'package:spotted/profile/profile_state.dart';
import 'package:spotted/models/models.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository repository;  
  ProfileBloc({@required this.repository}) : assert(repository != null);

  @override
  ProfileState get initialState => ProfileEmpty();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
   if (event is FetchProfile) {
      print("Fetching my Profile ");
      yield ProfileLoading();

      try {
        final User userProfile = await repository.fetchMyProfile();

        print("Profile bloc");

        print(userProfile);

        if (userProfile != null) yield ProfileLoaded(user: userProfile);
      } catch (e) {
        yield ProfileError("Error Getting Profile Information");
      }
   }
   else if (event is SaveProfile) {
      yield ProfileSaving();

      print(event);
      print(event.user);
      try {
        final String message = await repository.updateUser(event.user);
        print(message);

        yield ProfileLoaded(user: event.user);

      } catch (_) {
        yield ProfileError("Error saving profile information");
      }
    }

    }
}
