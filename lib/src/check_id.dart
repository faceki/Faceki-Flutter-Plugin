
import 'package:fackikyc/src/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';


import 'constant/app_text_style.dart';
import 'constant/colors.dart';
import 'front_page_document.dart';

class CheckId extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Verify your identity",
                  style: AppTextStyles.regularColor(fontSize: 24),
                ),
                Icon(
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
                "You'll need to take a photo of your ID.",
                style: AppTextStyles.regular(
                  fontSize: 18,
                  color: Color(0xff585858),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
            child: Image.asset("inst.png".imagePath,
            package: "fackikyc",),
            ),
            Expanded(
              child: SizedBox(
                  // height: 100,
                  ),
            ),
           
          
            Container(
              width: MediaQuery.of(context).size.width*0.87 ,
           
                 alignment: Alignment.bottomRight,
              child: Container(
                
             
                width: 70,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FrontPageDocument()));
                  },
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
            ),
            Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  "footlogo.svg".imagePath,
            package: "fackikyc",
                  height: 30,
                  width: 50,
                )),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

}