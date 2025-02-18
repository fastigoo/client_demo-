class ServerException implements Exception {}

class OfflineException implements Exception {}

class WrongEmailException implements Exception {}

class WrongPasswordException implements Exception {}

class CustomException implements Exception {
  String msg;
  CustomException({required this.msg});
}
