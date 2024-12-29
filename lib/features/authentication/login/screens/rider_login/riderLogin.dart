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

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo + Text
              Image.asset("assets/images/content/rider_signup.png", height: 150),
              const SizedBox(height: 16),
              Text(
                "Join as a Roadie today!",
                style: GoogleFonts.poppins(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                "Log in to start driving and earning",
                style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  color: textColor.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32.0),

              // Email Field
              BuzzcabTextField(
                labelText: "Email Address",
                controller: _emailController,
                isDarkMode: isDarkMode,
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter Your Email Address",
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),

              // Password Field
              BuzzcabTextField(
                labelText: "Password",
                hintText: "Enter Your Password",
                controller: _passwordController,
                isDarkMode: isDarkMode,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline),
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 8),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: isDarkMode ? Colors.blueAccent : Colors.red,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32.0),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? Colors.blueAccent : const Color(0xFF211F96),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  child: Text(
                    'Log In',
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // Sign Up Link
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RiderSignupScreen()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "New member? ",
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: textColor,
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
