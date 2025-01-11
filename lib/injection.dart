import 'package:get/get.dart';
// import 'package:learning/features/post/data/datasources/post_datasource.dart';
// import 'package:learning/features/post/data/repositories/posts_repository_imp.dart';
// import 'package:learning/features/post/domain/repositories/post_repository.dart';
// import 'package:learning/features/post/domain/usecases/get_posts_usecase.dart';

Future<void> injectionInit() async {

  /**
   * USECASES
   */

  // Get.lazyPut(() => GetPostsUseCase(postRepository: Get.find<PostRepository>()));

  /**
   * REPOSITORIES
   */

  // Get.lazyPut<PostRepository>(() => PostsRepositoryImplement(postsDataSource: Get.find<PostDataSource>()));

  /**
   * DATASOURCES
   */

  // Get.lazyPut<PostDataSource>(() => PostDataSourceImp());

}
