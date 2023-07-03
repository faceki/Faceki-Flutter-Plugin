import 'package:fackikyc/src/constant/extension.dart';
import 'package:fackikyc/src/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'check_id.dart';
import 'constant/app_text_style.dart';
import 'constant/colors.dart';

class VerifyDocument extends StatefulWidget {
  @override
  State<VerifyDocument> createState() => _VerifyDocumentState();
}
bool isSelected=false;
final _repository=Get.find<Repository>();

class _VerifyDocumentState extends State<VerifyDocument> {
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
                "To do this, we'll need the following.. ",
                style: AppTextStyles.regular(
                  fontSize: 18,
                  color: Color(0xff585858),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "1",
                        style: GoogleFonts.inter(
                          color: Color(0xff4C4E64),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 30,
                        width: 2,
                        color: Color(0xff4C4E64).withOpacity(0.1),
                      ),
                      Text(
                        "2",
                        style: GoogleFonts.inter(
                          color: Color(0xff4C4E64),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 30,
                        width: 2,
                        color: Color(0xff4C4E64).withOpacity(0.1),
                      ),
                      Text(
                        "3",
                        style: GoogleFonts.inter(
                          color: Color(0xff4C4E64),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 1, 1, 1)
                                  .withOpacity(0.05),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset("front_card.svg".imagePath,
                                  package: "fackikyc", height: 30, width: 100),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RichText(
                                  maxLines: 2,
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Picture of your ",
                                      style: GoogleFonts.inter(
                                        color:
                                            Color(0xff4C4E64).withOpacity(0.87),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  TextSpan(
                                      text: "${_repository.selectedIdType}",
                                      style: GoogleFonts.inter(
                                        color:
                                            Color(0xff4C4E64).withOpacity(0.87),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  TextSpan(
                                      text: " - Front ",
                                      style: GoogleFonts.inter(
                                        color:
                                            Color(0xff4C4E64).withOpacity(0.87),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ))
                                ])),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xff4C4E64).withOpacity(0.05),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset("back_card.svg".imagePath,
                                  package: "fackikyc", height: 30, width: 100),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Picture of your ",
                                      style: GoogleFonts.inter(
                                        color:
                                            Color(0xff4C4E64).withOpacity(0.87),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  TextSpan(
                                      text: "${_repository.selectedIdType}",
                                      style: GoogleFonts.inter(
                                        color:
                                            Color(0xff4C4E64).withOpacity(0.87),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  TextSpan(
                                      text: " - Back ",
                                      style: GoogleFonts.inter(
                                        color:
                                            Color(0xff4C4E64).withOpacity(0.87),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ))
                                ])),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xff4C4E64).withOpacity(0.05),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                "back_card.svg".imagePath,
                                package: "fackikyc",
                                height: 30,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Take a selfie picture",
                                    style: GoogleFonts.inter(
                                      color:
                                          Color(0xff4C4E64).withOpacity(0.87),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ]))
                            ],
                          )),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                  // height: 100,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Consents ",
                    style: GoogleFonts.inter(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline)),
                TextSpan(
                    text: "&",
                    style: GoogleFonts.inter(
                      color: Color(0xff747171),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                TextSpan(
                    text: " Terms of use ",
                    style: GoogleFonts.inter(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline)),
              ])),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      isSelected=value??false;
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: AppColors.primaryColor,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "I confirm I have read, understood and agree to continue.",
                    style: GoogleFonts.inter(
                      color: Color(0xff747171),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.87,
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  if(isSelected)
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckId()));
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
