import 'package:buzzcab/features/onboradingScreen/onboardingFirst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'featuresDriver/utils/constants/text_strings.dart';
import 'featuresDriver/utils/device/web_material_scroll.dart';
import 'featuresDriver/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: _getInitialScreen(),
    );
  }

  Widget _getInitialScreen() {
    try {
      return OnboardingFirst();
    } catch (e) {
      debugPrint("Error loading OnboardingFirst: $e");
      return const Scaffold(
        body: Center(child: Text("Something went wrong! Restart the app.")),
      );
    }
  }
}
