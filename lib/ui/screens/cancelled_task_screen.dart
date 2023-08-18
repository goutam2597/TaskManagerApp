import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';
import 'package:task_management_api/ui/screens/state_managers/cancelled_task_controller.dart';
import 'package:task_management_api/ui/screens/update_task_status_sheet.dart';
import 'package:task_management_api/ui/widgets/task_list_tile.dart';
import 'package:task_management_api/ui/widgets/user_profile_appbar.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTasks(taskId));
    if (response.isSuccess) {
      _cancelledTaskController.taskListModel.data!
          .removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
        if (mounted) {
          Get.snackbar(
            'Congratulations!',
            'Task Deletion Successful',
            colorText: Colors.white,
            messageText: const Text(
              'Task Deletion Successful',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          );
        }
      }
    } else {
      if (mounted) {
        Get.snackbar(
          'Ops!',
          'Task Deletion Failed',
          colorText: Colors.white,
          messageText: const Text(
            'Task Deletion Failed',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _cancelledTaskController.getCancelledTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _cancelledTaskController.getCancelledTask();
          },
          child: Column(
            children: [
              const UserProfileAppBar(),
              GetBuilder<CancelledTaskController>(builder: (_) {
                if (_cancelledTaskController.getCancelledTsk) {
                  return const Center(child: LinearProgressIndicator());
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16,left: 6, right: 6),
                    child: ListView.separated(
                      itemCount:
                          _cancelledTaskController.taskListModel.data?.length ??
                              0,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          data:
                              _cancelledTaskController.taskListModel.data![index],
                          oneDeleteTap: () {
                            deleteTask(_cancelledTaskController
                                .taskListModel.data![index].sId!);
                          },
                          onEditTap: () {
                            showStatusUpdateBottomSheet(_cancelledTaskController
                                .taskListModel.data![index]);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 4,
                        );
                      },
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(
          task: task,
          onUpdate: () {
            _cancelledTaskController.getCancelledTask();
          },
        );
      },
    );
  }
}
