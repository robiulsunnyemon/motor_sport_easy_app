import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:motor_sport_easy/app/routes/app_pages.dart';

import '../../widgets/custom_elevated_button.dart';
import '../controllers/update_race_dashboard_controller.dart';

class UpdateRaceDashboardView extends GetView<UpdateRaceDashboardController> {
  const UpdateRaceDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: screenWidth<600? Color(0xFFF3F3F3):Colors.white,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Center(
            child: Container(
              width: 900,
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(color: const Color(0xFFF3F3F3)),
              child: screenWidth > 600
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 40,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Update Race',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: CustomElevatedButton(onTap: (){
                          Get.toNamed(Routes.RACE_ADMIN);
                        }, level: "Dashboard"),
                      )
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 32,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 24,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    SizedBox(
                                      width: 390,
                                      child: Text(
                                        'Race Name',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: controller
                                            .raceNameController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'This Field is required';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText:
                                          'write a Race name..',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //logo section
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 24,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      'Paste Logo Link',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'This Field is required';
                                          }
                                          return null;
                                        },
                                        controller: controller.imageUrlController,
                                        decoration: InputDecoration(
                                          hintText: 'https//:www.google.com/image',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 295,
                    child: CustomElevatedButton(
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          final raceData = {
                            'title': controller.raceNameController.text,
                            'logoUrl': controller.imageUrlController.text,
                            'createdAt': FieldValue.serverTimestamp(),
                          };
                          controller.updateRace(raceData);
                        }
                      },
                      level: "Save",
                    ),
                  ),
                ],
              )
                  : ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Update Race',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: CustomElevatedButton(onTap: (){
                          Get.toNamed(Routes.RACE_ADMIN);
                        }, level: "Dashboard"),
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 32,
                    children: [
                      Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              SizedBox(
                                width: 390,
                                child: Text(
                                  'Race Name',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  controller:
                                  controller.raceNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This Field is required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'write a Race name..',
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                      //logo section
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            'Paste Logo Link',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'This Field is required';
                                }
                                return null;
                              },
                              controller: controller.imageUrlController,
                              decoration: InputDecoration(
                                hintText: 'https//:www.google.com/image',
                              ),
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),

                  SizedBox(height: 24),
                  CustomElevatedButton(
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        final raceData = {
                          'title': controller.raceNameController.text,
                          'logoUrl': controller.imageUrlController.text,
                          'createdAt': FieldValue.serverTimestamp(),
                        };
                        controller.updateRace(raceData);
                      }
                    },
                    level: "Save",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
