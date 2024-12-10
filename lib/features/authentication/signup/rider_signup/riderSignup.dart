import 'package:buzzcab/common/widgets/textfield/buzzcabTextField.dart';
import 'package:buzzcab/features/authentication/login/screens/rider_login/riderLogin.dart';
import 'package:buzzcab/features/registration/rider_registration/driverRegStep1.dart';
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
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
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
                // Name
                BuzzcabTextField(
                  labelText: "Full Name",
                  hintText: "Enter Your Full Name",
                  controller: _nameController,
                  isDarkMode: isDarkMode,
                  keyboardType: TextInputType.text,
                ),
                // Mobile
                BuzzcabTextField(
                  labelText: "Mobile",
                  // hintText: "Enter Mobile Number",
                  controller: _mobileController,
                  prefixText: "+91 ",
                  isDarkMode: isDarkMode,
                  keyboardType: TextInputType.phone,
                ),
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

                // Terms and Conditions Text
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          termsAndConditions = !termsAndConditions;
                        });
                      },
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            width: 2,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        child: termsAndConditions
                            ? Icon(
                                Icons.check,
                                weight: 0.1,
                                color: isDarkMode ? Colors.white : Colors.black,
                                size: 20.0,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'By signing up, you agree to our ',
                          style: GoogleFonts.poppins(
                            fontSize: 12.0,
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xFF212121),
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF211F96),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color(0xFF212121),
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy.',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF211F96),
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

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DriverRegStep1()),
                      );
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
                      'Sign up',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Signup as Roadie
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RiderLoginScreen()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already a member? ",
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Log In',
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
                    GestureDetector(
                      onTap: () {
                        // Add navigation to Roadie signup screen
                      },
                      child: RichText(
                        text: TextSpan(
                            text: "Signup as ",
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text: 'Rider',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF211F96),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.all(8),
      //   child: Column(
      //     children: [
      //       // Sign Up Button
      //       SizedBox(
      //         width: double.infinity,
      //         child: ElevatedButton(
      //           onPressed: () {
      //             // Add your navigation logic here
      //           },
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor:
      //                 isDarkMode ? Colors.blue : const Color(0xFF211F96),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8.0),
      //             ),
      //             padding: const EdgeInsets.symmetric(vertical: 16.0),
      //           ),
      //           child: const Text(
      //             'Sign up',
      //             style: TextStyle(
      //                 fontSize: 16.0,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.white),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 16.0),

      //       // Signup as Roadie
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           GestureDetector(
      //             onTap: () {
      //               // Adding the navigation
      //             },
      //             child: Text(
      //               "Already a member? Log In",
      //               style: GoogleFonts.poppins(
      //                 fontSize: 14.0,
      //                 color: isDarkMode ? Colors.white : Colors.black,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: () {
      //               // Add navigation to Roadie signup screen
      //             },
      //             child: Text(
      //               'Signup as Rider',
      //               style: TextStyle(
      //                 fontSize: 14.0,
      //                 color: isDarkMode ? Colors.white : Colors.black,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       const SizedBox(height: 16.0),
      //     ],
      //   ),
      // ),
    );
  }
}
