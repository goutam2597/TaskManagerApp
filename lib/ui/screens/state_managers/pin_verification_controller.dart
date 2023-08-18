import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class PinVerificationController extends GetxController{

  bool _otpVerificationInProgress = false;

  bool get otpVerificationInProgress => _otpVerificationInProgress;

  Future<bool> verifyOTP(String email, String otp) async {
    _otpVerificationInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.otpVerification(email.trim(),otp.trim()));
    _otpVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

}