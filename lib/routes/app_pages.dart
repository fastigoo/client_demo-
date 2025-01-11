import 'package:get/get.dart';
import 'package:learning/features/home/presentation/bindings/home_binding.dart';
import 'package:learning/features/home/presentation/screens/home_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
