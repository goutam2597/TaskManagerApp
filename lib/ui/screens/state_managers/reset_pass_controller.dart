import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class ResetPassController extends GetxController{
  bool _resetPasswordInProgress = false;

  bool get resetPasswordInProgress => _resetPasswordInProgress;

  Future<bool> resetPassword(String email,String otp,String password) async {
    _resetPasswordInProgress = true;
    update();

    final Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.recoverResetPass, requestBody);
    _resetPasswordInProgress = false;
    update();
    if (response.isSuccess) {
        return true;
    } else {
      return false;
    }
  }
}