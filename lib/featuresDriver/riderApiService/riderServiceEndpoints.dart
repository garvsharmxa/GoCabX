import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Riderserviceendpoints {
  static const String baseUrl =

  'http://192.168.1.24:4000/api'; 


  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<Map<String, dynamic>> sendOtp(String mobileNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/otp/send-otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': mobileNumber,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  // Verify the OTP sent to the mobile number and return the response
  static Future<Map<String, dynamic>> verifyOtp(
      String mobileNumber, String otp, String sessionId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/otp/verify-otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': mobileNumber,
        'otp': otp,
        'sessionid': sessionId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify OTP');
    }
  }
// Upload Live Photo of Shop
  Future<Map<String, dynamic>> riderPhotoUpload(String photoPath) async {
    final token = await getToken();
    try {
      final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/kyc/upload-live-photos'));
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('photos', photoPath));

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final data = jsonDecode(responseData.body);
        return {
          'success': true,
          'message': 'Shop photo uploaded successfully',
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to upload shop photo: ${responseData.body}',
        };
      }
    } catch (error) {
      print('Error uploading shop photo: $error');
      return {
        'success': false,
        'message': 'An error occurred: $error',
      };
    }
  }


}