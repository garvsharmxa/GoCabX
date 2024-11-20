class MobileNumberValidator {
  static bool isValidPhoneNumber(String number) {
    final RegExp phoneRegExp = RegExp(r'^[6-9]\d{9}$');  // India-specific validation
    return phoneRegExp.hasMatch(number);
  }
}
