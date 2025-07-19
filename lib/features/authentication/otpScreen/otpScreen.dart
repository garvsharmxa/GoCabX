import 'dart:convert';
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

  OtpController({required this.mobileNumber, required String sessionId}) {
    this.sessionId.value = sessionId;
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
                  onTap: (){},
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
                  onPressed:  () {
                    Get.offAll(() => const ProfileSetupScreen());
                  },
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
