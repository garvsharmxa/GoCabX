class PhoneNumberValidator {
  static const String countryCode = "+91 ";

  static bool isValidPhoneNumber(String phoneNumber) {
    // Check if the phone number starts with "+91 " and has exactly 10 digits afterward
    final regex = RegExp(r'^\+91 \d{10}$');
    return regex.hasMatch(phoneNumber);
  }
}
