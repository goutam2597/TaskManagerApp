import 'package:get/get.dart';
import 'package:task_management_api/data/models/auth_utility.dart';
import 'package:task_management_api/data/models/login_model.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class LoginController extends GetxController {
  bool _signInInProgress = false;

  bool get loginInProgress => _signInInProgress;

  Future<bool> userSignIn(String email, String password) async {
    _signInInProgress = true;
    update();

    Map<String, dynamic> requestBody = <String, dynamic>{
      "email": email,
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.login, requestBody, isLogin: true);
    _signInInProgress = false;
    update();
    if (response.isSuccess) {
      await AuthUtility.saveUserInfo(LoginModel.fromJson(response.body!));
      return true;
    } else {
      return false;
    }
  }
}
