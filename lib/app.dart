import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/authentication/signup/signup.dart';
import 'navigation_menu.dart';
import 'onboradingScreen/onboardingFirst.dart';
import 'utils/constants/colors.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system, // Automatically adapts to system settings
      theme: TAppTheme.lightTheme, // Light theme configuration
      darkTheme: TAppTheme.darkTheme, // Dark theme configuration
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: OnboardingFirst(),
      // SignUpScreen()
      // NavigationMenu()
    );
  }
}
