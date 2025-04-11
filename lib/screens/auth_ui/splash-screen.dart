// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zm_zone/controller/get-user-data-controller.dart';

import '../../utils/app-constant.dart';
import '../admin-panel/admin-main-screen.dart';
import '../user-panel/main-screen.dart';
import 'welcome-screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Start a timer to navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      logging();
    });
  }

  Future<void> logging() async {
    try {
      if (user != null) {
        // Fetch user data from Firestore
        final GetUserDataController getUserDataController = Get.put(GetUserDataController());
        var userData = await getUserDataController.getUserData(user!.uid);
        print("User Data: $userData"); // Debug print

        // Check if userData is not empty
        if (userData.isNotEmpty) {
          // Navigate to AdminMainScreen or MainScreen based on isAdmin flag
          if (userData[0]['isAdmin'] == true) {
            Get.off(() => AdminMainScreen());
          } else {
            Get.off(() => MainScreen());
          }
        } else {
          // Handle the case where userData is empty
          print("User data is empty. Redirecting to WelcomeScreen.");
          Get.off(() => WelcomeScreen());
        }
      } else {
        // Handle the case where user is null (not logged in)
        Get.off(() => WelcomeScreen());
      }
    } catch (e) {
      // Handle any exceptions that occur
      print("Error in logging: $e");
      Get.off(() => WelcomeScreen()); // Fallback to a safe screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appScendoryColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appScendoryColor,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Lottie.asset('assets/images/splash-icon.json'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              width: Get.width,
              alignment: Alignment.center,
              child: Text(
                AppConstant.appPoweredBy,
                style: TextStyle(
                  color: AppConstant.appTextColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}