import 'package:buzzcab/Constant/base_url.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/widgets/bottomButton.dart';
import 'user_rider_switch.dart';
import 'widget/onboardingTextFirst.dart';

class OnboardingFirst extends StatelessWidget {
  const OnboardingFirst({super.key});

  Future<void> fetchAndSaveRoles(BuildContext context) async {
    String url = BaseUrl.rolesList;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': '', // Add token if required
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          // Save entire roles data
          await prefs.setString('roles_data', jsonEncode(data['data']));

          // Extract and save Passenger & Driver roleId
          List roles = data['data'];
          int? passengerRoleId;
          int? driverRoleId;

          for (var role in roles) {
            if (role['slug'] == 'passenger') {
              passengerRoleId = role['roleId'];
              await prefs.setInt('passenger_role_id', passengerRoleId!);
            } else if (role['slug'] == 'driver') {
              driverRoleId = role['roleId'];
              await prefs.setInt('driver_role_id', driverRoleId!);
            }
          }

          print('Passenger Role ID: $passengerRoleId');
          print('Driver Role ID: $driverRoleId');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChoosePathScreen(
                driverRoleId: driverRoleId ?? 0,
                passengerRoleId: passengerRoleId ?? 0,
              ),
            ),
          );
        } else {
          throw Exception('Failed to fetch roles');
        }
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching roles: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch roles. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
    Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF121212)
        : const Color(0xFFE6F5F3);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 150.0,
            decoration: const BoxDecoration(
              color: Color(0xFF25B29F),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'assets/logos/applogo.png',
                height: 20,
                width: 20,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const OnboardingText(
            text: "Welcome To",
            fontSize: 30.0,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 8),
          const OnboardingText(
            text: "BuzzCabs!",
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 32),
          Center(
            child: Lottie.asset(
              'assets/images/animations/Intro_Screen_animation-BuzzCab.json',
              width: double.infinity,
              height: 200.0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: GradientButtonBar(
          onPressed: () => fetchAndSaveRoles(context),
          buttonText: "Get Started",
        ),
      ),
    );
  }
}
