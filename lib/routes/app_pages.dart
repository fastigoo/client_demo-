import 'package:get/get.dart';
import 'package:learning/features/post/presentation/bindings/post_binding.dart';
import 'package:learning/features/post/presentation/screens/posts_screen.dart';
import 'package:learning/features/profile/presentation/screens/profile_screen.dart';
import 'package:learning/features/splash/presentation/bindings/splash_binding.dart';
import 'package:learning/features/splash/presentation/screens/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: _Paths.INITIAL,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.POSTS,
      page: () => const PostsScreen(),
      binding: PostBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileScreen(),
      binding: PostBinding(),
    ),
  ];
}
