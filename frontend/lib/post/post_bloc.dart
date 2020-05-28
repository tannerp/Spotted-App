import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:spotted/repositories/repository.dart';
import 'package:spotted/models/models.dart';
import 'package:spotted/post/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  PostBloc({@required this.repository}) : assert(repository != null);

  @override
  PostState get initialState => PostEmpty();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is FetchNewsfeed) {
      yield PostLoading();

      try {
        final List<dynamic> posts =
            await repository.fetchNewsFeed().then((value) {
          return value;
        });
        if (posts != null) yield NewsfeedReady(posts: posts);
      } catch (e) {
        yield PostError("Please enter your content");
      }
    } else if (event is FetchMyPosts) {
      print("Fetching my post ");
      yield PostLoading();

      try {
        final List<dynamic> posts =
            await repository.fetchMyPosts().then((value) {
          return value;
        });
        print("Post bloc " + posts.toString());
        if (posts != null) yield MyPostsReady(my_posts: posts);
      } catch (e) {
        yield PostError("Please enter your content");
      }
    } else if (event is SavePost) {
      yield PostSaving();

      try {
        final String message = await repository.createPost(event.post);
        yield PostEmpty();
      } catch (_) {
        yield PostError("Failed to save post");
      }
    } else if (event is DeletePost) {
      yield PostDeleted("Successful deleted post");
      // We don't have api for delete post i'll leave this comment out
      /*try {
        final String message = await repository.deletePost(event.post);
        yield PostDeleted();
      } catch (_) {
        yield PostError("Failed to delete post");     
      }*/
    }
  }
}
