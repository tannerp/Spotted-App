import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:spotted/repositories/repository.dart';
import 'package:spotted/models/models.dart';
import 'package:spotted/post/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepo;
  final UserRepository userRepo;

  PostBloc({@required this.postRepo, @required this.userRepo}) : assert(postRepo != null), assert(postRepo != null);

  @override
  PostState get initialState => PostEmpty();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is FetchNewsfeed) {
      yield PostLoading();

      try {
        final List<Post> posts =
            await postRepo.fetchNewsFeed().then((value) {
          return value;
        });
        if (posts != null) yield NewsfeedReady(posts: posts);
      } catch (e) {
        yield PostError("Failed to get posts");
      }
   
   
    } else if (event is FetchMyPosts) {
      yield PostLoading();

      try {
        final List<Post> posts =
            await postRepo.fetchMyPosts().then((value) {
          return value;
        });
        if (posts != null) yield MyPostsReady(my_posts: posts);
      } catch (e) {
        yield PostError("Failed to get posts");
      }
   
   
    } else if (event is SavePost) {
      yield PostSaving();

      try {
        final String message = await postRepo.createPost(event.post);
        yield PostEmpty();
      } catch (_) {
        yield PostError("Failed to save posts");
      }
   
   
    } else if (event is DeletePost) {
      yield PostDeleted("Successful deleted posts");
      // We don't have api for delete post i'll leave this comment out
      /*try {
        final String message = await postRepo.deletePost(event.post);
        yield PostDeleted();
      } catch (_) {
        yield PostError("Failed to delete post");     
      }*/
    }
  }
}
