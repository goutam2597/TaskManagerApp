import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_api/ui/screens/splash_screen.dart';
import 'package:task_management_api/ui/screens/state_managers/cancelled_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/completed_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/email_verification_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/get_new_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/in_progress_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/pin_verification_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/reset_pass_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/signup_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/update_task_status_controller.dart';

import 'ui/screens/state_managers/add_new_task_controller.dart';
import 'ui/screens/state_managers/login_controller.dart';
import 'ui/screens/state_managers/summary_count_controller.dart';

class TaskManager extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManager.globalKey,
      title: 'Task Manager',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

      ),
      themeMode: ThemeMode.light,
      initialBinding: ControllerBinding(),
      home: const SplashScreen(),
    );
  }
}

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<SignUpController>(SignUpController());
    Get.put<EmailVerificationController>(EmailVerificationController());
    Get.put<PinVerificationController>(PinVerificationController());
    Get.put<ResetPassController>(ResetPassController());
    Get.put<SummaryCountController>(SummaryCountController());
    Get.put<GetNewTaskController>(GetNewTaskController());
    Get.put<AddNewTaskController>(AddNewTaskController());
    Get.put<InProgressTaskController>(InProgressTaskController());
    Get.put<CancelledTaskController>(CancelledTaskController());
    Get.put<CompletedTaskController>(CompletedTaskController());
    Get.put<UpdateTaskStatusController>(UpdateTaskStatusController());
  }

}