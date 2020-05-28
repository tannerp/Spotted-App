import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:spotted/repositories/repository.dart';
import 'package:spotted/profile/profile_event.dart';
import 'package:spotted/profile/profile_state.dart';
import 'package:spotted/models/user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository repository;  
  ProfileBloc({@required this.repository}) : assert(repository != null);

  @override
  ProfileState get initialState => ProfileEmpty();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    // if (event is FetchNewsfeed) {
    //   yield PostLoading();
   if (event is FetchProfile) {
      print("Fetching my Profile ");

      yield ProfileLoaded(user: User(firstName: "test", lastName: "test last name", token: "12312513"));
   }

    //   try {
    //     final List<dynamic> posts =
    //         await repository.fetchMyPosts().then((value) {
    //       return value;
    //     });
    //     if (posts != null) yield MyPostsReady(posts: posts);
    //   } catch (e) {
    //     yield PostError("Please enter your content");
    //   }
    // } else if (event is SavePost) {
    //   yield PostSaving();

    //   try {
    //     // final String message = await repository.createPost(event.Profile);
    //     yield PostEmpty();
    //   } catch (_) {
    //     yield PostError("Failed to save Profile");
    //   }
    // }
    // else if (event is DeletePost) {
    //   yield PostDeleted("Successful deleted Profile");
    //   // We don't have api for delete Profile i'll leave this comment out
    //   /*try {
    //     final String message = await repository.deletePost(event.Profile);
    //     yield PostDeleted();
    //   } catch (_) {
    //     yield PostError("Failed to delete Profile");     
    //   }*/
    }
}
