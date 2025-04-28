class BaseUrl {
  static const String _base = 'http://13.49.117.190:7022/v1';

  static String get rolesList => '$_base/roles/list';
  static String get register => '$_base/auth/register';
  static String get sendOtp => '$_base/auth/send-otp';
  static String get verifyOtp => '$_base/auth/verify-otp';
}
