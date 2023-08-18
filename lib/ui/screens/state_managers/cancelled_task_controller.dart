import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class CancelledTaskController extends GetxController{
  bool _getCancelledTsk = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCancelledTsk => _getCancelledTsk;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCancelledTask() async {
    _getCancelledTsk = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.cancelledTasks);
    _getCancelledTsk = false;
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