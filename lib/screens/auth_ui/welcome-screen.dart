import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/google-sign-in-controller.dart';
import '../../utils/app-constant.dart';
import 'sign-in-screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppConstant.appScendoryColor,
          title: Text(
            'Welcome to my App',
            style: TextStyle(color: AppConstant.appTextColor),
          ),
        ),
        body: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            child: Lottie.asset('assets/images/splash-icon.json'),
          ),
          Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Happy Shopping",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          SizedBox(
            height: Get.height / 12,
          ),
          Material(
            child: Container(
              width: Get.width / 1.2,
              height: Get.height / 12,
              decoration: BoxDecoration(
                color: AppConstant.appScendoryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextButton.icon(
                onPressed: () {
                  _googleSignInController.signInWithGoogle();
                },
                label: Text(
                  "Sign In with google",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                icon: Image.asset(
                  'assets/images/final-google-logo.png',
                  width: Get.width / 12,
                  height: Get.height / 12,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height / 50,
          ),
          Material(
              child: Container(
            width: Get.width / 1.2,
            height: Get.height / 12,
            decoration: BoxDecoration(
              color: AppConstant.appScendoryColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextButton.icon(
                onPressed: () {
                  Get.to(() => SignInScreen());
                },
                label: Text(
                  'Sign in with email',
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                icon: Icon(
                  Icons.email,
                  color: AppConstant.appTextColor,
                )),
          ))
        ])));
  }
}
