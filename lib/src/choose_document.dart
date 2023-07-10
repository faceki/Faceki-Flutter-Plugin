import 'package:fackikyc/src/constant/extension.dart';
import 'package:fackikyc/src/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'constant/app_text_style.dart';
import 'constant/colors.dart';
import 'verify_document.dart';

class ChooseDocument extends StatefulWidget {
  @override
  State<ChooseDocument> createState() => _ChooseDocumentState();
}

class _ChooseDocumentState extends State<ChooseDocument> {
  final repository = Get.find<Repository>();
  String? groupValue;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Verify your identity",
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
                "Select a document type..",
                style: AppTextStyles.regular(
                  fontSize: 18,
                  color: Color(0xff585858),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Obx(
            () {
                return Expanded(
                  // height: 200,
                  child: ListView.builder(
                      itemCount: repository.rules.value.length,
                      itemBuilder: (context, index) {
                        final item=repository.rules.value[index];
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width * 0.8,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 1, 1, 1)
                                                .withOpacity(0.05),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            // SizedBox(
                                            //   width: 10,
                                            // ),
                                            Radio(
                                                activeColor: AppColors.primaryColor,
                                                value: "${item}",
                                                groupValue: groupValue,
                                                onChanged: (v) {
                                                  setState(() {
                                                    groupValue = v;
                                                    repository.selectedIdType=v;
            
                                                  });
                                                }),
                                            SvgPicture.asset(
                                                "front_card.svg".imagePath,
                                                package: "fackikyc",
                                                height: 30,
                                                width: 100),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: "$item",
                                                  style: GoogleFonts.inter(
                                                    color: Color(0xff4C4E64)
                                                        .withOpacity(0.87),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                            ]))
                                          ],
                                        )),
                                        const SizedBox(height: 10,)
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
            ),
            const Expanded(
              child: SizedBox(
                  // height: 100,
                  ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.87,
              alignment: Alignment.bottomRight,
              child: Container(
                width: 70,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: GestureDetector(
                  onTap: () {
                    if(groupValue!=null){
                      repository.selectedType(groupValue!);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyDocument()));
                    }
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
                margin: EdgeInsets.only(left: 30),
                child: SvgPicture.asset(
                  "footlogo.svg".imagePath,
                  package: "fackikyc",
                  fit: BoxFit.cover,
                  height: 30,
                  width: 50,
                )),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
//  SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                             width: MediaQuery.of(context).size.width * 0.8,
//                             height: 70,
//                             decoration: BoxDecoration(
//                                 color: Color(0xff4C4E64).withOpacity(0.05),
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Row(
//                               children: [
//                                 // SizedBox(
//                                 //   width: 10,
//                                 // ),
//                                 Radio(
//                                     activeColor: AppColors.primaryColor,
//                                     value: "passport",
//                                     groupValue: groupValue,
//                                     onChanged: (v) {
//                                       setState(() {
//                                         groupValue = v;
//                                       });
//                                     }),
//                                 SvgPicture.asset("back_card.svg".imagePath,
//                                     package: "fackikyc",
//                                     height: 30,
//                                     width: 100),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 RichText(
//                                     text: TextSpan(children: [
//                                   TextSpan(
//                                       text: "Passport",
//                                       style: GoogleFonts.inter(
//                                         color:
//                                             Color(0xff4C4E64).withOpacity(0.87),
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w700,
//                                       )),
//                                 ]))
//                               ],
//                             )),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                             width: MediaQuery.of(context).size.width * 0.8,
//                             height: 70,
//                             decoration: BoxDecoration(
//                                 color: Color(0xff4C4E64).withOpacity(0.05),
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Radio(
//                                     activeColor: AppColors.primaryColor,
//                                     value: "driver",
//                                     groupValue: groupValue,
//                                     onChanged: (v) {
//                                       setState(() {
//                                         groupValue = v;
//                                       });
//                                     }),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 SvgPicture.asset(
//                                   "user.svg".imagePath,
//                                   package: "fackikyc",
//                                   height: 30,
//                                   width: 100,
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 RichText(
//                                     text: TextSpan(children: [
//                                   TextSpan(
//                                       text: "Take a selfie picture",
//                                       style: GoogleFonts.inter(
//                                         color:
//                                             Color(0xff4C4E64).withOpacity(0.87),
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w700,
//                                       )),
//                                 ]))
//                               ],
                            // )),