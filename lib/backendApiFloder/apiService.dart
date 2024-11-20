// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {
//   static const String baseUrl ='https://agrictools-backend-dot-project-101-396902.el.r.appspot.com/api';
//       // 'http://192.168.137.1:4000/api'; // Replace with actual backend URL
// //server url 
// //  'https://agrictools-backend-dot-project-101-396902.el.r.appspot.com/api'
//   // Send OTP to the specified mobile number and return the response
//   static Future<Map<String, dynamic>> sendOtp(String mobileNumber) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/otp-app/send-otp'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'phoneNumber': mobileNumber,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to send OTP');
//     }
//   }

//   // Verify the OTP sent to the mobile number and return the response
//   static Future<Map<String, dynamic>> verifyOtp(
//       String mobileNumber, String otp, String sessionId) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/otp-app/verify-otp'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
      
//       body: jsonEncode(<String, String>{
//         'phoneNumber': mobileNumber,
//         'otp': otp,
//         'sessionid': sessionId,
//       }),
//     );
//     print(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to verify OTP');
//     }
//   }
//     Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('auth_token');
//   }
// }


// class JwtDecoder {
//   static String? getUserId(String token) {
//     try {
//       // Decode the token to get the payload
//       final payload = Jwt.parseJwt(token);
      
//       // Extract userId from the payload
//       final userId = payload['user']['id'] as String?;
//       return userId;
//     } catch (e) {
//       print('Error decoding JWT token: $e');
//       return null;
//     }
//   }
// }



// class Jwt {
//   static Map<String, dynamic> parseJwt(String token) {
//     final parts = token.split('.');
//     if (parts.length != 3) {
//       throw FormatException('Invalid token.');
//     }

//     final payload = _decodeBase64(parts[1]);
//     final payloadMap = json.decode(payload);
//     if (payloadMap is! Map<String, dynamic>) {
//       throw FormatException('Invalid payload.');
//     }

//     return payloadMap;
//   }

//   static String _decodeBase64(String str) {
//     String output = str.replaceAll('-', '+').replaceAll('_', '/');

//     switch (output.length % 4) {
//       case 0:
//         break;
//       case 2:
//         output += "==";
//         break;
//       case 3:
//         output += '=';
//         break;
//       default:
//         throw Exception('Illegal base64 string.');
//     }

//     return utf8.decode(base64Url.decode(output));
//   }

//   static bool isExpired(String token) {
//     final DateTime? expirationDate = getExpiryDate(token);
//     if (expirationDate != null) {
//       return DateTime.now().isAfter(expirationDate);
//     } else {
//       return false;
//     }
//   }

//   static DateTime? getExpiryDate(String token) {
//     final Map<String, dynamic> payload = parseJwt(token);
//     if (payload['exp'] != null) {
//       return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true)
//           .add(Duration(seconds: payload["exp"]));
//     }
//     return null;
//   }
// }