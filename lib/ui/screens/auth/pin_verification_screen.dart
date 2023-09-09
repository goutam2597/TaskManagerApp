import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_api/ui/screens/auth/login_screen.dart';
import 'package:task_management_api/ui/screens/auth/set_new_password_screen.dart';
import 'package:task_management_api/ui/screens/state_managers/pin_verification_controller.dart';
import 'package:task_management_api/ui/widgets/screen_backgrounds.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;

  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool isPinValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PIN Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'A 6 digit verification pin has sent to your email address',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                PinCodeTextField(
                  controller: _otpController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.white,
                      activeColor: Colors.white,
                      selectedColor: Colors.white,
                      selectedFillColor: Colors.white),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  cursorColor: Colors.deepOrange,
                  enablePinAutofill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {
                    if (value.length == 6) {
                      setState(() {
                        isPinValid = true;
                      });
                    } else {
                      setState(() {
                        isPinValid = false;
                      });
                    }
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<PinVerificationController>(
                    builder: (pinVerificationController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible:
                          pinVerificationController.otpVerificationInProgress ==
                              false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: isPinValid
                            ? () {
                          pinVerificationController
                              .verifyOTP(widget.email, _otpController.text.trim())
                              .then((result) {
                            if (result == true) {
                              Get.offAll(ResetPasswordScreen(
                                  email: widget.email, otp: _otpController.text.trim()));
                            } else {
                              Get.snackbar(
                                'Ops!',
                                'Otp Verification Failed! Try Again.',
                                colorText: Colors.black,
                                messageText: const Text(
                                  'Otp Verification Failed! Try Again.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }
                          });
                        }
                            : null,
                        child: const Text('Verify'),
                      ),

                    ),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive the OTP??",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, letterSpacing: 0.5),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Resend'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
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
                        Get.offAll(const LoginScreen());
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
    );
  }
}
