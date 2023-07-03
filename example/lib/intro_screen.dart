
import 'package:example/choose_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'verify_document.dart';
import 'constant/app_text_style.dart';
import 'constant/colors.dart';


class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 70,),
          SvgPicture.asset(
            "assets/images/logo_faceki.svg",
            
            height: 50,
            width: 255,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Verify your identity",
            style: AppTextStyles.regularColor(fontSize: 24),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset("assets/images/Scan_img.svg"),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(ChooseDocument());
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    width: 70,
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
                            "Next",
                            style: AppTextStyles.regular(
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
          Container
          (
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 10),
            child: SvgPicture.asset("assets/images/footlogo.svg",height: 30,width: 50,)),

        ],
      ),
    );
  }
}
