// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../utils/app-constant.dart';

class HeadingWidget extends StatelessWidget{
  final String headingTitle;
  final String headingSubtitle;
  final VoidCallback onTap;
  final String buttonText;

  HeadingWidget({
    required this.headingTitle,
    required this.headingSubtitle,
    required this.onTap,
    required this.buttonText
  });

  @override
  Widget build(BuildContext context){
    return Container(
      margin : EdgeInsets.symmetric(horizontal : 5.0, vertical : 5.0),
      child : Padding(
        padding : EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment : MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingTitle,
                  style : TextStyle(
                    fontWeight : FontWeight.bold,
                    color : Colors.grey.shade800,
                  ),
                ),
                Text(
                  headingSubtitle,
                  style : TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize : 12.0,
                    color : Colors.grey,
                  )
                )
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border : Border.all( color : AppConstant.appScendoryColor,
                  width: 1.5,
                  ),
                ),
              child: Padding(
                padding : EdgeInsets.all(8.0),
                child : Text(
                buttonText,
                 style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: AppConstant.appScendoryColor),
                )
              ),
              ),
            ),
          ],
        ),
      )
    );
  }
}