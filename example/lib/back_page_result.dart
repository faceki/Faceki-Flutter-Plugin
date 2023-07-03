import 'dart:io';

import 'package:example/guidance_page.dart';
import 'package:example/selfie_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant/app_text_style.dart';
import 'constant/colors.dart';

class BackPageResult extends StatelessWidget{
File file;
File frontFile;
BackPageResult({required this.file, required this.frontFile});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
                Text(
                  "Clarity Check",
                  style: AppTextStyles.regularColor(fontSize: 24),
                ),
                const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Make sure picture and text are clear",
                style: AppTextStyles.regular(
                  fontSize: 18,
                  color: const Color(0xff585858),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(file,),fit: BoxFit.cover),
                      border: Border.all(
                          color: const Color(0xff7B7B7B), width: 15)),
                
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: (){

                Get.to(GuidancePage(backId: file,frontId: frontFile,));
              },
              child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor.withOpacity(0.5),width: 1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                                  "LOOKS GOODS",
                                  style: AppTextStyles.regular(
                      fontSize: 16,
                      color: AppColors.primaryColor
                                  ),
                                ),
                    ),
                  )),
            ),
                SizedBox(height: 10,),
            Center(
                child: Text(
              "Retake the photo",
              style: AppTextStyles.regular(
                fontSize: 16,
                
              ),
            )),
            const SizedBox(
              height: 40,
            ),
         
          ],
        ),
      ),
    ); 
  }
}