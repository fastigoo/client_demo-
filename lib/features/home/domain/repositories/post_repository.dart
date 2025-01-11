

import 'package:dartz/dartz.dart';
import 'package:learning/features/post/domain/entities/post_entity.dart';

abstract interface class PostRepository {
  Future<Either<String, List<PostEntity>>> getPosts();
}