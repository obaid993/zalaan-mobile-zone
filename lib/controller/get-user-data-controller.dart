// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserDataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch user data from Firestore
  Future<List<Map<String, dynamic>>> getUserData(String uId) async {
    try {
      // Query the 'user' collection for documents where 'uId' matches the provided uId
      final QuerySnapshot userData = await _firestore
          .collection('users')
          .where('uId', isEqualTo: uId)
          .get();

      // If documents are found, convert them to a list of maps
      if (userData.docs.isNotEmpty) {
        return userData.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      } else {
        // If no documents are found, return an empty list
        print("No user data found for uId: $uId");
        return [];
      }
    } catch (e) {
      // Handle any errors that occur during the query
      print("Error fetching user data: $e");
      return [];
    }
  }
}