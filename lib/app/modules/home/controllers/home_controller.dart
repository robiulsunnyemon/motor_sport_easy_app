import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_elevated_button.dart';

class HomeController extends GetxController {

  Future<void> showRequestDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
       return AlertDialog(
         backgroundColor: Colors.white,
         title: Text(
           'Request',
           style: TextStyle(
             color: Colors.black,
             fontSize: 16,
             fontFamily: 'Inter',
             fontWeight: FontWeight.w400,
           ),
         ),
         content: SizedBox(
             height: 10,
           width: 300,
         ),
         actions: <Widget>[
           CustomElevatedButton(
             level: "Request a racing series",
             onTap: (){
               Get.back();
               showRequestSeriesDialog(context);
             },
           ),
           SizedBox(height: 10,),
           CustomElevatedButton(
             level: "Report",
             onTap: (){
               Get.back();
               showRequestReportDialog(context);
             },
             isBackgroundWhite: true,
             isBorderRed: true,
           ),
         ],
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
       );
      },
    );
  }

  Future<void> showRequestSeriesDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Request a racing series',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          content: SizedBox(
            height: 100,
            width: 300,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Write your request...",
                hintStyle: TextStyle(
                  color: Colors.black.withValues(alpha: 0.40),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor:  Color(0xFFF3F4F6),
              ),
              maxLines: 5,
            ),
          ),
          actions: <Widget>[
            CustomElevatedButton(
              level: "Send a Request",
              onTap: (){
                Get.back();
              },
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      },
    );
  }

  Future<void> showRequestReportDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Report',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          content: SizedBox(
            height: 100,
            width: 300,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Write your report hare...",
                hintStyle: TextStyle(
                  color: Colors.black.withValues(alpha: 0.40),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor:  Color(0xFFF3F4F6),
              ),
              maxLines: 5,
            ),
          ),
          actions: <Widget>[
            CustomElevatedButton(
              level: "Send a Request",
              onTap: (){
                Get.back();
              },
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      },
    );
  }

}
