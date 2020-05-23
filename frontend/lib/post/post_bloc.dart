import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:spotted/repositories/repository.dart';
import 'package:spotted/models/models.dart';
import 'package:spotted/post/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  List<Post> _newsfeed;

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
          print(value);
          return value;
        });
        if (posts != null) yield NewsfeedReady(posts: posts);
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
    }
  }
}
