import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_api/data/models/network_response.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/services/network_caller.dart';
import 'package:task_management_api/data/utils/urls.dart';
import 'package:task_management_api/ui/screens/add_new_task_screen.dart';
import 'package:task_management_api/ui/screens/state_managers/get_new_task_controller.dart';
import 'package:task_management_api/ui/screens/state_managers/summary_count_controller.dart';
import 'package:task_management_api/ui/screens/update_task_status_sheet.dart';
import 'package:task_management_api/ui/widgets/summery_card.dart';
import 'package:task_management_api/ui/widgets/task_list_tile.dart';
import 'package:task_management_api/ui/widgets/user_profile_appbar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final SummaryCountController _summaryCountController =
      Get.find<SummaryCountController>();

  final GetNewTaskController _getNewTaskController =
      Get.find<GetNewTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _summaryCountController.getCountSummary();
      _getNewTaskController.getNewTask();
    });
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteTasks(taskId));
    if (response.isSuccess) {
      _getNewTaskController.taskListModel.data!
          .removeWhere((element) => element.sId == taskId);
      _summaryCountController.getCountSummary();
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
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Task Deletion Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            const AddNewTaskScreen(),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _getNewTaskController.getNewTask();
            _summaryCountController.getCountSummary();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const UserProfileAppBar(),
              GetBuilder<SummaryCountController>(builder: (_) {
                if (_summaryCountController.getCountSummaryInProgress) {
                  return const Center(child: LinearProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Center(
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return SummeryCard(
                            title: _summaryCountController
                                    .summaryCountModel.data?[index].sId ??
                                'New',
                            number: _summaryCountController
                                    .summaryCountModel.data?[index].sum ??
                                0,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
              Expanded(
                child: GetBuilder<GetNewTaskController>(builder: (_) {
                  if (_getNewTaskController.getNewTaskInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: ListView.separated(
                      itemCount:
                          _getNewTaskController.taskListModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskListTile(
                          data:
                              _getNewTaskController.taskListModel.data![index],
                          oneDeleteTap: () {
                            deleteTask(_getNewTaskController
                                .taskListModel.data![index].sId!);
                          },
                          onEditTap: () {
                            showStatusUpdateBottomSheet(_getNewTaskController
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
                  );
                }),
              )
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
            _getNewTaskController.getNewTask();
            _summaryCountController.getCountSummary();
          },
        );
      },
    );
  }
}
