import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'featuresDriver/onboradingScreen/onboardingFirst.dart';
import 'featuresDriver/utils/constants/text_strings.dart';
import 'featuresDriver/utils/device/web_material_scroll.dart';
import 'featuresDriver/utils/theme/theme.dart';

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
      home:
      //  HomeScreen(),
      OnboardingFirst(),
      // DriveOfflinePage()
      // ErrorScreen(),
      // LoadingPage(),
      // LoadingPage2(),
      // RideCancelPage(),
      // RideCompletePage(),
      // SaveRide(),
      // SwitchingPage(),
      // const Thankspage()

      // SignUpScreen()
      // NavigationMenu()
    );
  }
}
