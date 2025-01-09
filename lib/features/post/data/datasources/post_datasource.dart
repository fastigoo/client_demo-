


import 'package:dio/dio.dart';
import 'package:learning/features/post/data/models/post_model.dart';

abstract interface class PostDataSource {
  Future<List<PostModel>> getPosts();
}

class PostDataSourceImp implements PostDataSource {
  @override
  Future<List<PostModel>> getPosts() async {


    Dio dio = Dio();
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    List<PostModel> posts = (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    return posts;
  }
}