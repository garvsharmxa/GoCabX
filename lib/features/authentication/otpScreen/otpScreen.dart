import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../navigation_menu.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void dispose() {
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFF7F23),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF7F23), Color(0xFFFF9447)],
              begin: AlignmentDirectional(1.0, 0.0),
              end: AlignmentDirectional(-1.0, 0.0),
            ),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.max,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Check your phone',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We’ve sent the code to your phone',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // PinCodeTextField(
                  //   appContext: context,
                  //   length: 6,
                  //   controller: _pinCodeController,
                  //   textStyle: const TextStyle(
                  //     fontFamily: 'Readex Pro',
                  //     letterSpacing: 0.0,
                  //   ),
                  //   pinTheme: PinTheme(
                  //     fieldHeight: 50.0, // Adjust height if needed
                  //     fieldWidth: 50.0, // Adjust width if needed
                  //     shape: PinCodeFieldShape.circle,

                  //     activeColor: Colors.transparent,
                  //     inactiveColor: Colors.grey,
                  //     selectedColor: Colors.white,
                  //     activeFillColor: Colors
                  //         .transparent, // Background color when field is active
                  //     inactiveFillColor: Color(
                  //         0xFFFFE4D1), // Background color when field is inactive
                  //     selectedFillColor: const Color(
                  //         0xFFFFE4D1), // Background color when field is selected
                  //   ),
                  //   enableActiveFill: true, // Enables background color
                  //   onChanged: (value) {},
                  // ),
                  const SizedBox(height: 16),
                  const Text(
                    'code expires in: 2:00',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 34),
                  _buildButton(context, 'Verify', Colors.white, Colors.black,
                      () => Get.to(() => const NavigationMenu())),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: 50,
                      width: 250,
                      child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              side: BorderSide(
                                color: Colors.white,
                              ), // Outline border color and width
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )),
                          onPressed: () {},
                          child: Text('Send again')))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color,
      Color textColor, VoidCallback onPressed,
      {Color? borderColor}) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide.none,
          foregroundColor: textColor,
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
