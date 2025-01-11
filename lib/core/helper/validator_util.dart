import 'dart:io';

class ValidatorUtil {
  static String? nullableValidation(var x, {String? customMessage}) {
    if (x == null) return customMessage ?? 'validatorDefaultErrorMessage';
    return null;
  }

  static String? imageFileValidation(File? x, int maxSize,
      {String? customMessage}) {
    if (nullableValidation(x) == null) {
      final bytes = x?.readAsBytesSync().lengthInBytes ?? 0;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      return mb < maxSize
          ? null
          : customMessage ?? 'validatorDefaultErrorMessage';
    }
    return null;
  }

  static String? phoneValidation(String phone, {String? customMessage}) {
    if (RegExp(r"^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$").hasMatch(phone) !=
            true ||
        phone.length != 9 ||
        !(phone[0] == '6' || phone[0] == '5' || phone[0] == '7')) {
      return customMessage ?? 'validatorDefaultErrorMessage';
    }
    return null;
  }
}
