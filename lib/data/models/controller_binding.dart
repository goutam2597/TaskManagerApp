import 'package:get/get.dart';
import 'package:task_management_api/ui/screens/state_managers/add_new_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/cancelled_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/completed_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/email_verification_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/get_new_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/in_progress_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/login_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/pin_verification_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/reset_pass_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/signup_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/summary_count_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/update_task_status_controller.dart';

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