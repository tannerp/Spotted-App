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

  // Future<List<Post>> fetchPost() async {
  //   // build posts
  // List<dynamic> posts = await postApiClient.fetchNewsfeed();

  // print(posts);

  // return posts;
  // }

  Future<List<dynamic>> fetchNewsFeed() async {
    final List<dynamic> result = await postApiClient.fetchNewsfeed();
    // return postApiClient .fetchNewsfeed();

    print("Post repo");
    print(result);
    return result;
    // final List<Post> result = response["posts"].map((rawPost) {
    //           print(rawPost);
    //           return Post(
    //             id: rawPost['id'],
    //             title: rawPost['title'],
    //             body: rawPost['content'],
    //           );
    //         }).toList();

    //   print("Post repository");
    //   print(rsp["posts"]);

    //   // final rsp["posts"] = json.decode(rsp["posts"]) as List;

    //   final dynamic rst = rsp["posts"].map((rawPost) {
    //     print(rawPost);
    //     return Post(
    //       id: rawPost['id'],
    //       title: rawPost['title'],
    //       body: rawPost['content'],
    //     );
    //   }).toList();
    //   print("inside then");
    //   result = rst;
    // });
   
  }

  Future<String> createPost(Post post) async {
    return await postApiClient.createPost(post);
  }
}
