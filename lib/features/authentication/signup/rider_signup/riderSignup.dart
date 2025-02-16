import 'package:buzzcab/Constant/base_url.dart';
import 'package:buzzcab/common/widgets/textfield/buzzcabTextField.dart';
import 'package:buzzcab/features/authentication/login/screens/rider_login/riderLogin.dart';
import 'package:buzzcab/featuresDriver/registration/rider_registration/driverRegStep1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RiderSignupScreen extends StatefulWidget {
  const RiderSignupScreen({super.key});

  @override
  _RiderSignupScreenState createState() => _RiderSignupScreenState();
}

class _RiderSignupScreenState extends State<RiderSignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool termsAndConditions = false;

  int? DriverRoleId;

  @override
  void initState() {
    super.initState();
    _loadPassengerRoleId();
  }

  Future<void> _loadPassengerRoleId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      DriverRoleId =
          prefs.getInt('driver_role_id'); // Default to 3 if not found
    });
  }

  Future<void> _registerUser() async {
    String mobile = _mobileController.text.trim();

    // Remove country code if present
    if (mobile.startsWith("+91")) {
      mobile = mobile.substring(3);
    }

    // Remove any non-numeric characters
    mobile = mobile.replaceAll(RegExp(r'\D'), '');

    if (mobile.isEmpty || mobile.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 10-digit mobile number")),
      );
      return;
    }

    final String apiUrl = BaseUrl.register;

    Map<String, dynamic> requestBody = {
      "roleId": DriverRoleId,
      "mobile": mobile,
      "email": _emailController.text.trim(),
      "firstName": _nameController.text.split(" ")[0],
      "lastName": _nameController.text.split(" ").length > 1
          ? _nameController.text.split(" ")[1]
          : ""
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful!")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DriverRegStep1()),
        );
      } else {
        String errorMessage = "Registration failed. Please try again.";

        if (responseData.containsKey("message")) {
          if (responseData["message"].toString().toLowerCase().contains("already exists")) {
            errorMessage = "User with this mobile number or email is already registered. Try logging in instead.";
          } else if (responseData["message"].toString().toLowerCase().contains("invalid email")) {
            errorMessage = "Invalid email address. Please enter a valid email.";
          } else if (responseData["message"].toString().toLowerCase().contains("invalid mobile")) {
            errorMessage = "Invalid mobile number. Please enter a valid 10-digit number.";
          } else {
            errorMessage = responseData["message"];
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e. Please check your internet connection and try again.")),
      );
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color primaryColor =
        isDarkMode ? Colors.blueAccent : Color(0xFF211F96);
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color borderColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset("assets/images/content/rider_signup.png",
                          scale: 3.5),
                      const SizedBox(height: 12),
                      Text(
                        "Join as a Roadie today!",
                        style: GoogleFonts.poppins(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      Text(
                        "Sign up to start riding and earning",
                        style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: textColor.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                BuzzcabTextField(
                    labelText: "Full Name",
                    hintText: "Enter Your Full Name",
                    controller: _nameController,
                    isDarkMode: isDarkMode,
                    keyboardType: TextInputType.text),
                BuzzcabTextField(
                    labelText: "Mobile Number",
                    controller: _mobileController,
                    isDarkMode: isDarkMode,
                    keyboardType: TextInputType.phone),
                BuzzcabTextField(
                    labelText: "Email Address",
                    hintText: "Enter Your Email",
                    controller: _emailController,
                    isDarkMode: isDarkMode,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email_outlined, color: borderColor)),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          termsAndConditions = !termsAndConditions;
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(width: 2, color: borderColor),
                        ),
                        child: termsAndConditions
                            ? Icon(Icons.check, color: primaryColor, size: 20.0)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'By signing up, you agree to our ',
                          style: GoogleFonts.poppins(
                              fontSize: 12.0, color: textColor),
                          children: [
                            TextSpan(
                                text: 'Terms & Conditions',
                                style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                                text: ' and ',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.0, color: textColor)),
                            TextSpan(
                                text: 'Privacy Policy.',
                                style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    decoration: TextDecoration.underline)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RiderLoginScreen()));
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already a member? ",
                          style: GoogleFonts.poppins(
                              fontSize: 14.0, color: textColor),
                          children: [
                            TextSpan(
                                text: 'Log In',
                                style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    decoration: TextDecoration.underline)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
