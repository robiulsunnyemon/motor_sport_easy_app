import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/set_notification_alert_dialog.dart';

class RacingDetailsController extends GetxController {
  RxInt setHour=1.obs;
  RxBool is8Hour=false.obs;
  RxBool is3Hour=false.obs;
  RxBool is6Hour=false.obs;




  void increaseSetHour(){
    setHour.value++;
    update();
  }
  void decreaseSetHour(){
   if(setHour.value>1){
     setHour.value--;
     update();
   }
  }
  void set8Hour(){
    if(is8Hour.value==false){
      is8Hour.value=true;
    }else{
      is8Hour.value=false;
    }
    update();
  }
  void set3Hour(){
    if(is3Hour.value==false){
      is3Hour.value=true;
    }else{
      is3Hour.value=false;
    }
    update();
  }
  void set6Hour(){
    if(is6Hour.value==false){
      is6Hour.value=true;
    }else{
      is6Hour.value=false;
    }
    update();
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return SetNotificationAlertDialog();
      },
    );
  }
}
