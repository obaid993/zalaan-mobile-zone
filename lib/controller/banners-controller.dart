// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<String> bannersUrls = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();
    fetchBannersUrls();
  }

  Future<void> fetchBannersUrls() async {
    try {
      QuerySnapshot bannersSnapshot =
          await FirebaseFirestore.instance.collection('banners').get();
      if (bannersSnapshot.docs.isNotEmpty) {
        bannersUrls.value = bannersSnapshot.docs
            .map((doc) => doc['imageUrl'] as String)
            .toList();
      }
    } catch (e) {
      print("Error : $e");
    }
  }
}
