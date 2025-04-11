// ignore_for_file: unused_field, unused_local_variable, body_might_complete_normally_nullable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../models/user-model.dart';
import '../utils/app-constant.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isPasswordVisible = false.obs;

  Future<UserCredential?> signUpMethod(
  String userName,
  String userEmail,
  String userPhone,
  String userCity,
  String userPassword,
  String userDeviceToken,
) async {
  try {
    EasyLoading.show(status: "Please wait..");

    // Create user in Firebase Authentication
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    // Send email verification
    await userCredential.user!.sendEmailVerification();

    // Create user model
    UserModel userModel = UserModel(
      uId: userCredential.user!.uid,
      username: userName,
      email: userEmail,
      phone: userPhone,
      userImg: userCity, // Ensure this field is correct
      userDeviceToken: userDeviceToken,
      country: '',
      userAddress: '',
      street: '',
      isAdmin: false,
      isActive: true,
      createdOn: DateTime.now(),
      city: userCity,
    );

    // Save user data to Firestore
    await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(userModel.toMap())
        .then((_) {
      print("User data saved to Firestore successfully!");
    }).catchError((error) {
      print("Failed to save user data: $error");
    });

    EasyLoading.dismiss();
    return userCredential;
  } on FirebaseAuthException catch (e) {
    EasyLoading.dismiss();
    Get.snackbar(
      'Error',
      '$e',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppConstant.appScendoryColor,
      colorText: AppConstant.appTextColor,
    );
    return null;
  } catch (e) {
    EasyLoading.dismiss();
    print("Unexpected error: $e");
    Get.snackbar(
      'Error',
      'An unexpected error occurred. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppConstant.appScendoryColor,
      colorText: AppConstant.appTextColor,
    );
    return null;
  }
}
}
