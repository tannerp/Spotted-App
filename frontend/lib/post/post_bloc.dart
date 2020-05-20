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
    if (event is FetchPost) {
      yield PostLoading();
      try {
        final Post post = await repository.fetchPost();
        //print(post);
        yield PostLoaded(post: post);
      } catch (_) {
        yield PostError("Please enter your content");
      }
    }
    else if (event is SavePost) {
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