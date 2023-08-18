import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class AddNewTaskController extends GetxController{

  bool _addNewTaskInProgress = false;
  bool get addNewTaskInProgress => _addNewTaskInProgress;

  Future<bool> addNewTask(String title, String description) async {
    _addNewTaskInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _addNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      requestBody.clear();
      return true;
    } else {
      return false;
    }
  }
}