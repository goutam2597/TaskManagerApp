import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class CompletedTaskController extends GetxController{
  bool _getCompletedTsk = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCompletedTsk  => _getCompletedTsk;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCompletedTask() async {
    _getCompletedTsk = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.completedTasks);
    _getCompletedTsk = false;
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