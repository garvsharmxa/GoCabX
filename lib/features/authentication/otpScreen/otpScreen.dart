import 'dart:convert';
import 'package:buzzcab/Constant/base_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../common/widgets/colors/color.dart';
import '../../../featuresDriver/home/widgets/nextScreenButton.dart';
import '../login/screens/riderProfileSetup.dart';

class OtpController extends GetxController {
  var otp = ''.obs;
  var isLoading = false.obs;
  var isResendingOtp = false.obs;
  var sessionId = ''.obs;
  final String mobileNumber;
  VoidCallback? get verifyOtpCallback => isLoading.value ? null : verifyOtp;

  OtpController({required this.mobileNumber, required String sessionId}) {
    this.sessionId.value = sessionId;
  }

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> sendOtp() async {
    isResendingOtp(true);
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.sendOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': mobileNumber}),
      );
      final responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        sessionId.value = responseData['data']['sessionId'];
        Get.snackbar("Success", "OTP sent successfully",
            backgroundColor: AppColors.primary, colorText: Colors.white);
      } else {
        Get.snackbar("Error", responseData['message'] ?? 'Failed to send OTP',
            backgroundColor: AppColors.primary, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP");
    } finally {
      isResendingOtp(false);
    }
  }

  Future<void> verifyOtp() async {
    if (otp.value.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(otp.value)) {
      Get.snackbar("Error", "Please enter a valid 6-digit numeric OTP",
          backgroundColor: AppColors.primary, colorText: Colors.white);
      return;
    }

    if (sessionId.isEmpty) {
      Get.snackbar("Error", "Session ID missing, please resend OTP",
          backgroundColor: AppColors.primary, colorText: Colors.white);
      return;
    }

    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.verifyOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobile': mobileNumber,
          'otp': int.parse(otp.value),
          'sessionId': sessionId.value,
        }),
      );
      final responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        final token = responseData['data']['token'];
        if (token != null) await _storeToken(token);
        Get.offAll(() => const ProfileSetupScreen());
        Get.snackbar("Success", "OTP Verified Successfully!",
            backgroundColor: AppColors.primary, colorText: Colors.white);
      } else {
        Get.snackbar(
            "Error", responseData['message'] ?? 'OTP verification failed',
            backgroundColor: AppColors.primary, colorText: Colors.white);
      }
    } catch (error) {
      Get.snackbar("Error", "An error occurred while verifying OTP",
          backgroundColor: AppColors.primary, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }
}

class OtpScreen extends StatelessWidget {
  final String mobileNumber;
  final String sessionId;

  const OtpScreen(
      {Key? key, required this.mobileNumber, required this.sessionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(
        OtpController(mobileNumber: mobileNumber, sessionId: sessionId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'OTP Verification',
              style: GoogleFonts.poppins(
                  fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text("Enter the code sent to\n${controller.mobileNumber}",
                style: GoogleFonts.poppins(fontSize: 16),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            PinCodeTextField(
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.otp.value = value,
            ),
            const SizedBox(height: 16),
            Obx(() => GestureDetector(
                  onTap: controller.isResendingOtp.value
                      ? null
                      : controller.sendOtp,
                  child: Text(
                    controller.isResendingOtp.value
                        ? "Resending..."
                        : "Resend Code",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )),
            const Spacer(),
            Obx(() => Nextscreenbutton(
                  onPressed: controller.verifyOtpCallback ?? () {},
                  buttonText:
                      controller.isLoading.value ? "Verifying..." : "Verify",
                )),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
