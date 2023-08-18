import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_api/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_management_api/ui/screens/state_managers/add_new_task_controller.dart';
import 'package:task_management_api/ui/widgets/screen_backgrounds.dart';
import 'package:task_management_api/ui/widgets/user_profile_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileAppBar(),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Add New Task',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _titleTEController,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _descriptionTEController,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GetBuilder<AddNewTaskController>(
                        builder: (addNewTaskController) {
                          return SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: addNewTaskController.addNewTaskInProgress == false,
                              replacement:
                                  const Center(child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                onPressed: () {
                                  addNewTaskController.addNewTask(_titleTEController.text.trim(), _descriptionTEController.text).then(
                                        (result) {
                                      if (result == true) {
                                        Get.offAll(const BottomNavBaseScreen());
                                        Get.snackbar(
                                          'Congratulations!',
                                          'Add New Task Successful.',
                                          colorText: Colors.black,
                                          messageText: const Text(
                                            'Add New Task Successful.',
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
                                          'Add New Task Failed! Try Again.',
                                          colorText: Colors.black,
                                          messageText: const Text(
                                            'Add New Task Failed! Try Again',
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
                                child: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
