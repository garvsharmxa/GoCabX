import 'package:buzzcab/common/widgets/textfield/buzzcabTextField.dart';
import 'package:buzzcab/features/authentication/login/screens/rider_login/riderLogin.dart';
import 'package:buzzcab/featuresDriver/registration/rider_registration/driverRegStep1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderSignupScreen extends StatefulWidget {
  const RiderSignupScreen({Key? key}) : super(key: key);

  @override
  _RiderSignupScreenState createState() => _RiderSignupScreenState();
}

class _RiderSignupScreenState extends State<RiderSignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController =
  TextEditingController(text: "+91 ");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool termsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color primaryColor = isDarkMode ? Colors.blueAccent : Color(0xFF211F96);
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color borderColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/content/rider_signup.png",
                        scale: 3.5,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Join as a Roadie today!",
                        style: GoogleFonts.poppins(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        "Sign up to start riding and earning",
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: textColor.withOpacity(0.7),
                        ),
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
                  keyboardType: TextInputType.text,
                ),
                BuzzcabTextField(
                  labelText: "Mobile Number",
                  controller: _mobileController,
                  isDarkMode: isDarkMode,
                  keyboardType: TextInputType.phone,
                ),
                BuzzcabTextField(
                  labelText: "Email Address",
                  hintText: "Enter Your Email",
                  controller: _emailController,
                  isDarkMode: isDarkMode,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email_outlined, color: borderColor),
                ),
                BuzzcabTextField(
                  labelText: "Password",
                  hintText: "Create a strong password",
                  controller: _passwordController,
                  isDarkMode: isDarkMode,
                  obscureText: true,
                  prefixIcon: Icon(Icons.lock_outline, color: borderColor),
                ),
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
                          style: GoogleFonts.poppins(fontSize: 12.0, color: textColor),
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: GoogleFonts.poppins(
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(text: ' and ', style: GoogleFonts.poppins(fontSize: 12.0, color: textColor)),
                            TextSpan(
                              text: 'Privacy Policy.',
                              style: GoogleFonts.poppins(
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DriverRegStep1()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
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
                          MaterialPageRoute(builder: (context) => RiderLoginScreen()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already a member? ",
                          style: GoogleFonts.poppins(fontSize: 14.0, color: textColor),
                          children: [
                            TextSpan(
                              text: 'Log In',
                              style: GoogleFonts.poppins(
                                color: primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
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
