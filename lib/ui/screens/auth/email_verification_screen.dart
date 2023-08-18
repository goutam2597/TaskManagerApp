import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_api/ui/screens/auth/pin_verification_screen.dart';
import 'package:task_management_api/ui/screens/state_managers/email_verification_controller.dart';
import 'package:task_management_api/ui/widgets/screen_backgrounds.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'A 6 digit verification pin will send to your email address',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    onFieldSubmitted: (value) {
                      if (_formKey.currentState!.validate()) {}
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<EmailVerificationController>(
                    builder: (emailVerificationController) {
                      return SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: emailVerificationController.emailVerificationInProgress == false,
                          replacement:
                              const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {}
                              emailVerificationController.sendOTPToEmail(_emailController.text.trim()).then(
                                    (result) {
                                  if (result == true) {
                                    Get.offAll(PinVerificationScreen(email:_emailController.text.trim()));
                                  } else {
                                    Get.snackbar(
                                      'Ops!',
                                      'Send Otp Failed! Try Again.',
                                      colorText: Colors.black,
                                      messageText: const Text(
                                        'Send Otp Failed! Try Again.',
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
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, letterSpacing: 0.5),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
