import 'package:buzzcab/common/widgets/textfield/buzzcabTextField.dart';
import 'package:buzzcab/features/authentication/login/screens/forgot_password/forgotPassword.dart';
import 'package:buzzcab/features/authentication/signup/rider_signup/riderSignup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderLoginScreen extends StatefulWidget {
  const RiderLoginScreen({Key? key}) : super(key: key);

  @override
  _RiderLoginScreenState createState() => _RiderLoginScreenState();
}

class _RiderLoginScreenState extends State<RiderLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool termsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image + Text
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/content/rider_signup.png",
                      scale: 4,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Join as a Roadie today!",
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      "Log in to start driving and earning",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    )
                  ],
                ),
              ),
              // Rider Signup For
              const SizedBox(height: 24.0),
              // Email
              BuzzcabTextField(
                labelText: "Email Address",
                controller: _emailController,
                isDarkMode: isDarkMode,
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter Your Email Address",
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              // Password
              BuzzcabTextField(
                labelText: "Password",
                hintText: "Create a strong password",
                controller: _passwordController,
                isDarkMode: isDarkMode,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline),
                keyboardType: TextInputType.text,
              ),

              // Forgot Password
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      color: isDarkMode ? Colors.white : Colors.red,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your navigation logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDarkMode ? Colors.blue : const Color(0xFF211F96),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RiderSignupScreen()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "New member? ",
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF211F96),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
