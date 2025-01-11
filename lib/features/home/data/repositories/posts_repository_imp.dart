

import 'package:dartz/dartz.dart';
import 'package:learning/features/post/data/datasources/post_datasource.dart';
import 'package:learning/features/post/domain/entities/post_entity.dart';
import 'package:learning/features/post/domain/repositories/post_repository.dart';

class PostsRepositoryImplement implements PostRepository {
  final PostDataSource postsDataSource;

  PostsRepositoryImplement({required this.postsDataSource});

  @override
  Future<Either<String, List<PostEntity>>> getPosts() async {
    List<PostEntity> posts = await postsDataSource.getPosts();
    return Right(posts);
  }
}