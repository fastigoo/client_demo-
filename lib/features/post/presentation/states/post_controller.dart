import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:learning/features/post/domain/entities/post_entity.dart';
import 'package:learning/features/post/domain/usecases/get_posts_usecase.dart';

class PostController extends GetxController {
  final List<PostEntity> _posts = [];

  List<PostEntity> get getPostsList => _posts;

  final _getPostUseCase = Get.find<GetPostsUseCase>();

  RxBool isLoading = false.obs;

  // init
  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  Future<Either<String, List<PostEntity>>> getPosts() async {
    isLoading.value = true;
    Either<String, List<PostEntity>> response = await _getPostUseCase.call();
    response.fold(
      (l) {
        // print(l);
      },
      (List<PostEntity> posts) {
        _posts.addAll(posts);
      },
    );
    isLoading.value = false;
    return response;
  }
}
