import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  Future<bool> userSignUp(String email, String firstName,
      String lastName, String mobile, String password) async {
    _signUpInProgress = true;
    update();

    Map<String, dynamic> requestBody = <String, dynamic>{
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": "",
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, requestBody);
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      requestBody.clear();
      return true;
    } else {
      return false;
    }
  }
}
