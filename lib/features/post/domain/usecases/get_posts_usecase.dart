

import 'package:dartz/dartz.dart';
import 'package:learning/features/post/domain/entities/post_entity.dart';
import 'package:learning/features/post/domain/repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository postRepository;

  GetPostsUseCase({required this.postRepository});

  Future<Either<String, List<PostEntity>>> call() async {
    return await postRepository.getPosts();
  }
}