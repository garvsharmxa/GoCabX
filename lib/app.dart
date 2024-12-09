import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/Utils_Screen/DriveOfflinePage.dart';
import 'features/Utils_Screen/ErrorScreen.dart';
import 'features/Utils_Screen/LoadingPage.dart';
import 'features/Utils_Screen/LoadingPage2.dart';
import 'features/Utils_Screen/RideCancelPage.dart';
import 'features/Utils_Screen/RideCompletePage.dart';
import 'features/Utils_Screen/SaveRide.dart';
import 'features/Utils_Screen/SwitchingPage.dart';
import 'features/Utils_Screen/ThanksPage.dart';
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
      home:
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
