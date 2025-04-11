// ignore_for_file: unused_field, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/app-constant.dart';
import '../../widgets/all-products-widget.dart';
import '../../widgets/banner-widget.dart';
import '../../widgets/category-widget.dart';
import '../../widgets/custom-drawer-widget.dart';
import '../../widgets/flash-sale-widget.dart';
import '../../widgets/heading-widget.dart';
// import '../auth_ui/welcome-screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: AppConstant.appTextColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppConstant.appScendoryColor,
        statusBarBrightness: Brightness.light
      ),
      backgroundColor: AppConstant.appMainColor,
      centerTitle: true,
      title: Text(
        AppConstant.appMainName,
        style: TextStyle(color: AppConstant.appTextColor),
      ),
      actions: [
        // IconButton(
        //     onPressed: () async {
        //       await _auth.signOut();
        //       Get.off(() => WelcomeScreen());
        //     },
        //     icon: Icon(Icons.logout))
      ],
    ),
    drawer: DrawerWidget(),
    body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child : Column(
          children: [
            SizedBox(
              height : Get.height / 90.0,
            ),
          //banners
          BannerWidget(),

          //heading
          HeadingWidget(
          headingTitle: 'Categories', 
          headingSubtitle: "According to your budget", 
          onTap: (){}, 
          buttonText: "See More >"),
        CategoriesWidget(),
        // heading
        HeadingWidget(
        headingTitle: "Flash Sale", 
        headingSubtitle: "According to your budget", 
        onTap: (){}, 
        buttonText: "See More >",),
        FlashSaleWidget(),
        //all products
        HeadingWidget(headingTitle: "All Products", headingSubtitle: "According to your budget", onTap: (){}, 
        buttonText: "See More >"),
        AllProdutsWidget(),
        ],
        ),
      ),
    ),
    );
  }
}
