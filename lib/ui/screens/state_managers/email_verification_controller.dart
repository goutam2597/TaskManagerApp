import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class EmailVerificationController extends GetxController{
  bool _emailVerificationInProgress = false;

  bool get emailVerificationInProgress => _emailVerificationInProgress;

  Future<bool> sendOTPToEmail(String email) async {
    _emailVerificationInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.sendOTPToEmail(email.trim()));
    _emailVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}