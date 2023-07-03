import 'dart:io';


import 'package:fackikyc/src/constant/extension.dart';
import 'package:fackikyc/src/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import 'back_page_document.dart';
import 'constant/app_text_style.dart';
import 'constant/colors.dart';
import 'front_page_document.dart';
import 'guidance_page.dart';

class FrontPageResult extends StatelessWidget{
File file;
final _repository=Get.find<Repository>();
FrontPageResult({required this.file});
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
                  height: MediaQuery.of(context).size.height * 0.4,
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
                if(_repository.currentType=="Passport"){
                _repository.addSelectedDoc(file, file);
if(_repository.remainingDoc.isNotEmpty){
_repository.setNextDoc();
Get.to(FrontPageDocument());


}else{
           Navigator.push(context, MaterialPageRoute(builder: (context)=>  GuidancePage()));
}  
               return;
                }
Navigator.push(context, MaterialPageRoute(builder: (context)=>
               BackPageDocument(frontCard: file,)));
              },
              child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
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
            GestureDetector(
              onTap: (){

              Navigator.pop(context);
              },
              child: Center(
                  child: Text(
                "Retake the photo",
                style: AppTextStyles.regular(
                  fontSize: 16,
                  
                ),
              )),
            ),
            const SizedBox(
              height: 40,
            ),
             const Expanded(
            child: SizedBox(
                // height: 100,
                ),
          ),
          Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(
                "footlogo.svg".imagePath,
          package: "fackikyc",
                height: 30,
                width: 50,
              )),
          const SizedBox(
            height: 10,
          )
          ],
        ),
      ),
    ); 
  }
}