import 'dart:async';

import 'package:meta/meta.dart';

import 'package:spotted/repositories/post_api_client.dart';
import 'package:spotted/models/models.dart';

class PostRepository {
  final PostApiClient postApiClient;

  PostRepository({@required this.postApiClient})
      : assert(postApiClient != null);

  Future<Post> fetchPost() async {
    return await postApiClient.fetchPost();
  }

  Future<String> createPost(Post post) async {
    return await postApiClient.createPost(post);
  }

}