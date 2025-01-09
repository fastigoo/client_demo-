part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const INITIAL = _Paths.INITIAL;
  static const POSTS = _Paths.POSTS;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const INITIAL = '/splash';
  static const POSTS = '/posts';
  static const PROFILE = '/profile';
}