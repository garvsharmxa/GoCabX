class PhoneNumberValidator {
  static const String countryCode = "+91";

  static bool isValidPhoneNumber(String phoneNumber) {
    // Allow +91XXXXXXXXXX without space
    final regex = RegExp(r'^\+91\d{10}$');
    return regex.hasMatch(phoneNumber);
  }
}
