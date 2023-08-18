
import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';

class UpdateTaskStatusController extends GetxController {
  bool updateTaskInProgress = false;

  Future<bool> updateTask(String taskId, String newStatus) async {
    updateTaskInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.updateTasks(taskId, newStatus),
    );
    updateTaskInProgress = false;
    update();
    if (response.isSuccess) {
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
