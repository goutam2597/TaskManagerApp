import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class InProgressTaskController extends GetxController {
  bool _getTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getTaskInProgress => _getTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getInProgressTask() async {
    _getTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressTask);
    _getTaskInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
