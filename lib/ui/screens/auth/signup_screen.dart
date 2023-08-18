import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_api/ui/screens/auth/login_screen.dart';
import 'package:task_management_api/ui/screens/state_managers/signup_controller.dart';
import 'package:task_management_api/ui/widgets/screen_backgrounds.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Join With Us',
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
                      controller: _firstNameController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your First Name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'First Name'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your Last Name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'Last Name'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      validator: (String? value) {
                        if ((value?.isEmpty ?? true) || value!.length < 11) {
                          return 'Enter valid mobile number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'Mobile'),
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
                    GetBuilder<SignUpController>(builder: (signUpController) {
                      return SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: signUpController.signUpInProgress == false,
                          replacement:
                              const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              signUpController
                                  .userSignUp(
                                      _emailController.text.trim(),
                                      _firstNameController.text.trim(),
                                      _lastNameController.text.trim(),
                                      _mobileController.text.trim(),
                                      _passwordController.text)
                                  .then(
                                (result) {
                                  if (result == true) {
                                    Get.offAll(const LoginScreen());
                                    Get.snackbar(
                                      'Congratulations!',
                                      'SignUp Successful.',
                                      colorText: Colors.black,
                                      messageText: const Text(
                                        'SignUp Successful.',
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
                                      'Sign Up Failed! Try Again.',
                                      colorText: Colors.black,
                                      messageText: const Text(
                                        'Sign Up Failed! Try Again.',
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
      ),
    );
  }
}
