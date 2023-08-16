import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_api/data/models/auth_utility.dart';
import 'package:task_management_api/ui/screens/auth/login_screen.dart';
import 'package:task_management_api/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_management_api/ui/utils/assets_utils.dart';
import 'package:task_management_api/ui/widgets/screen_backgrounds.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  Future<void> navigateToLogin() async {
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final bool isLoggedIn = await AuthUtility.checkIfUserLoggedIn();
      if (mounted) {
        Get.offAll(
            isLoggedIn ? const BottomNavBaseScreen() : const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Image.asset(
            AssetsUtils.logoPng,
            width: 90,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
