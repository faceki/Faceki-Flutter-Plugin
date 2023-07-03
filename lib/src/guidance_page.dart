import 'dart:io';

import 'package:fackikyc/src/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import 'constant/app_text_style.dart';
import 'constant/colors.dart';
import 'selfie_page.dart';

class GuidancePage extends StatelessWidget {
  
  GuidancePage();
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
                GestureDetector(
                  onTap: ()=>Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Verify that it’s you",
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
                "Take a selfie",
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
                Padding(
                  padding: const EdgeInsets.only(left: 24,right: 24),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("imagefront.jpg".imagePath,
            package: "fackikyc",),
                            fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)
                        // border: Border.all(
                        //     color: const Color(0xff7B7B7B), width: 1)
                            ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
         
            Padding(
                      padding: const EdgeInsets.only(left: 48,right: 48),
              child: Text(
                "For the best scan results",
                style: AppTextStyles.bold(
              fontSize: 16,
              color: AppColors.primaryColor
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48,right: 48),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.black,
                    size: 17,
                  ),
              const SizedBox(width: 5,),
                  Text(
                    "Find an area with good lighting",
                    style: AppTextStyles.regular(
                        fontSize: 16, ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.only(left: 48,right: 48),
                   child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 const Icon(
                    Icons.remove_red_eye_rounded,
                    color: Colors.black,
                    size: 17,
                                 ),
                     const SizedBox(width: 5,),
                                 Text(
                    "Make sure your camera is at eye level",
                    style: AppTextStyles.regular(
                        fontSize: 16, ),
                                 ),
                               ],
                             ),
                 ),
             const SizedBox(
              height: 40,
            ),
             Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                     SelfiePage()));
                    // Get.to(ChooseDocument());
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "I'm Ready",
                            style: AppTextStyles.medium(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
            const SizedBox(
              height: 20,
            ),
             Padding(
               padding: const EdgeInsets.only(left: 24.0),
               child: Container
                       (
                         alignment: Alignment.bottomLeft,
                         margin: EdgeInsets.only(left: 10),
                         child: SvgPicture.asset("footlogo.svg".imagePath,
            package: "fackikyc",
                         height: 30,width: 50,)),
             ),

          ],
        ),
      ),
    );
  }
}
