import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zm_zone/screens/auth_ui/forget-password-screen.dart';

import '../../controller/get-user-data-controller.dart';
import '../../controller/sign-in-controller.dart';
import '../../utils/app-constant.dart';
import '../admin-panel/admin-main-screen.dart';
import '../user-panel/main-screen.dart';
import 'sign-up-screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appScendoryColor,
          centerTitle: true,
          title: Text(
            "Sign In",
            style: TextStyle(color: AppConstant.appTextColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              isKeyboardVisible
                  ? Text('Welcome to my App')
                  : Column(
                      children: [
                        Lottie.asset('assets/images/splash-icon.json'),
                      ],
                    ),
              SizedBox(height: Get.height / 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userEmail,
                    cursorColor: AppConstant.appScendoryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(
                    () => TextFormField(
                      controller: userPassword,
                      cursorColor: AppConstant.appScendoryColor,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: signInController.isPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            signInController.isPasswordVisible.toggle();
                          },
                          child: signInController.isPasswordVisible.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: AppConstant.appScendoryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 20),
              Material(
                child: Container(
                  width: Get.width / 2,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstant.appScendoryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      String email = userEmail.text.trim();
                      String password = userPassword.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appScendoryColor,
                          colorText: AppConstant.appTextColor,
                        );
                      } else {
                        try {
                          UserCredential? userCredential =
                              await signInController.signInMethod(
                                  email, password);

                          if (userCredential != null &&
                              userCredential.user != null) {
                            if (userCredential.user!.emailVerified) {
                              var userData = await getUserDataController
                                  .getUserData(userCredential.user!.uid);

                              if (userData.isNotEmpty) {
                                if (userData[0]['isAdmin'] == true) {
                                  Get.off(() => AdminMainScreen());
                                } else {
                                  Get.off(() => MainScreen());
                                }
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "User data not found. Please contact support.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appScendoryColor,
                                  colorText: AppConstant.appTextColor,
                                );
                              }
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please verify your email before login",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appScendoryColor,
                                colorText: AppConstant.appTextColor,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Sign-in failed. Please try again.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            "Error",
                            "An error occurred: ${e.toString()}",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        }
                      }
                    },
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(color: AppConstant.appTextColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: AppConstant.appScendoryColor),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => SignUpScreen()),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppConstant.appScendoryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
