import 'package:buzzcab/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'featuresDriver/navigation_menu.dart';
import 'featuresDriver/utils/constants/text_strings.dart';

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
      home: _getInitialScreen(),
    );
  }

  Widget _getInitialScreen() {
    try {
      // return OnboardingFirst();
      return NavigationMenu();
    } catch (e) {
      debugPrint("Error loading OnboardingFirst: $e");
      return const Scaffold(
        body: Center(child: Text("Something went wrong! Restart the app.")),
      );
    }
  }
}
