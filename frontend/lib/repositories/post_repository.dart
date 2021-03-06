import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:spotted/repositories/post_api_client.dart';
import 'package:spotted/repositories/user_repository.dart';
import 'package:spotted/models/models.dart';


class PostRepository {
  final PostApiClient postApiClient;
  final UserRepository userRepo;
  List<Post> _newsfeed;

  PostRepository({@required this.postApiClient, @required this.userRepo })
      : assert(postApiClient != null)
      , assert(userRepo != null);
      
  Future<List<Post>> fetchNewsFeed() async {
    final List<Post> result = await postApiClient.fetchNewsfeed(userRepo.token);
    return result;
  }

  Future<List<Post>> fetchMyPosts() async {
    final List<Post> result = await postApiClient.fetchMyPosts(userRepo.token);
    return result;
  }

  Future<String> createPost(Post post) async {
    return await postApiClient.createPost(userRepo.token, post);
  }

  Future<bool> toggleHelpPost(Post postID) async {
    print("Post Repo Toggle HELP POST");
    return await postApiClient.toggleHelpPost(userRepo.token, postID);
  }
}
