import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/ui/screens/state_managers/update_task_status_controller.dart';

class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusSheet(
      {super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  List<String> taskStatusList = ['New', 'Progress', 'Cancelled', 'Completed'];
  late String _selectedTask;

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          Container(
            height: 65,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.deepOrange,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Update Status',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.xmark,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskStatusList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    _selectedTask = taskStatusList[index];
                    setState(() {});
                  },
                  trailing: _selectedTask == taskStatusList[index]
                      ? const Icon(Icons.check)
                      : null,
                  title: Text(
                    taskStatusList[index].toUpperCase(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GetBuilder<UpdateTaskStatusController>(
              builder: (updateTaskStatusController) {
                return SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: Visibility(
                    visible: updateTaskStatusController.updateTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onUpdate();
                        updateTaskStatusController.updateTask(widget.task.sId!,_selectedTask).then(
                              (result) {
                            if (result == true) {
                              Get.back(result: true);
                              Get.snackbar(
                                'Congratulations!',
                                'Status Update Successful.',
                                colorText: Colors.black,
                                messageText: const Text(
                                  'Status Update Successful.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            } else {
                              Get.snackbar(
                                'Ops!',
                                'Status Update Failed! Try Again.',
                                colorText: Colors.black,
                                messageText: const Text(
                                  'Status Update Failed! Try Again.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                      child: const Text('Update'),
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
