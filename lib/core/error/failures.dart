abstract class Failure {}

class CustomFailure extends Failure {
  final String msg;

  CustomFailure({required this.msg});
}

class UserNotFoundFailure extends Failure {
  final String msg;

  UserNotFoundFailure({required this.msg});
}

class WrongOtpFailure extends Failure {
  final String msg;

  WrongOtpFailure({required this.msg});
}

class OfflineFailure extends Failure {}

class ServerFailure extends Failure {}

class WrongEmailFailure extends Failure {}

class WrongPasswordFailure extends Failure {}
