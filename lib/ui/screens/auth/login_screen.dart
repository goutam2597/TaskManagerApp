import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_api/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_management_api/ui/screens/state_managers/login_controller.dart';
import 'package:task_management_api/ui/widgets/screen_backgrounds.dart';
import 'email_verification_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started With',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          if (!value!.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length <= 5) {
                            return 'Enter Password more than 6 characters';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GetBuilder<LoginController>(builder: (loginController) {
                        return SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: loginController.loginInProgress == false,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                loginController
                                    .userSignIn(_emailController.text.trim(),
                                        _passwordController.text)
                                    .then(
                                  (result) {
                                    if (result == true) {
                                      Get.offAll(const BottomNavBaseScreen());
                                      Get.snackbar(
                                        'Congratulations!',
                                        'Login Successful.',
                                        colorText: Colors.black,
                                        messageText: const Text(
                                          'Login Successful.',
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
                                        'Login Failed! Try Again.',
                                        colorText: Colors.black,
                                        messageText: const Text(
                                          'Login Failed! Try Again',
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
                      }),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(const EmailVerificationScreen());
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(const SignUpScreen());
                            },
                            child: const Text('Sign up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
