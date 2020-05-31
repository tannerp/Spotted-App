import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:spotted/repositories/post_api_client.dart';
import 'package:spotted/models/models.dart';

class PostRepository {
  final PostApiClient postApiClient;
  List<Post> _newsfeed;

  PostRepository({@required this.postApiClient})
      : assert(postApiClient != null);
      
  Future<List<Post>> fetchNewsFeed() async {
    final List<Post> result = await postApiClient.fetchNewsfeed();
    // return postApiClient .fetchNewsfeed();
    print("Post repo");
    print(result);
    return result;
  }

  Future<List<Post>> fetchMyPosts() async {
    final List<Post> result = await postApiClient.fetchMyPosts();
    // return postApiClient .fetchNewsfeed();
    return result;
  }

  Future<String> createPost(Post post) async {
    return await postApiClient.createPost(post);
  }
}
