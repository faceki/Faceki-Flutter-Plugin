import 'package:fackikyc/constant1/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant/app_text_style.dart';

class ChooseDocument extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
              Text(
                "Verify your identity",
                style: AppTextStyles.regularColor(fontSize: 48),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.black,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Select a document type",
            style: AppTextStyles.regular(
              fontSize: 26,
              color: Color(0xff585858),
            ),
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "1",
                    style: GoogleFonts.inter(
                      color: Color(0xff4C4E64),
                      fontWeight: FontWeight.w600,
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 10,
                    width: 2,
                    color: Color(0xff666CFF),
                  ),
                  Text(
                    "2",
                    style: GoogleFonts.inter(
                      color: Color(0xff4C4E64),
                      fontWeight: FontWeight.w600,
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 10,
                    width: 2,
                    color: Color(0xff666CFF),
                  ),
                  Text(
                    "3",
                    style: GoogleFonts.inter(
                      color: Color(0xff4C4E64),
                      fontWeight: FontWeight.w600,
                      fontSize: 34,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 108,
                      decoration: BoxDecoration(
                        color: Color(0xff4C4E64).withOpacity(0.05),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset("res/images/front_card.svg"),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Picture of your ",
                                style: GoogleFonts.inter(
                                  color: Color(0xff4C4E64).withOpacity(0.87),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                )),
                            TextSpan(
                                text: "ID Card  ",
                                style: GoogleFonts.inter(
                                  color: Color(0xff4C4E64).withOpacity(0.87),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                )),
                            TextSpan(
                                text: " - Front ",
                                style: GoogleFonts.inter(
                                  color: Color(0xff4C4E64).withOpacity(0.87),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                ))
                          ]))
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 108,
                      decoration: BoxDecoration(
                        color: Color(0xff4C4E64).withOpacity(0.05),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset("res/images/back_card.svg"),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Picture of your ",
                                style: GoogleFonts.inter(
                                  color: Color(0xff4C4E64).withOpacity(0.87),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                )),
                            TextSpan(
                                text: "ID Card  ",
                                style: GoogleFonts.inter(
                                  color: Color(0xff4C4E64).withOpacity(0.87),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                )),
                            TextSpan(
                                text: " - Back ",
                                style: GoogleFonts.inter(
                                  color: Color(0xff4C4E64).withOpacity(0.87),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                ))
                          ]))
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 108,
                      decoration: BoxDecoration(
                        color: Color(0xff4C4E64).withOpacity(0.05),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset("res/images/back_card.svg"),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Take a selfie picture",
                                style: GoogleFonts.inter(
                                  color: Color(0xff4C4E64).withOpacity(0.87),
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                )),
                          ]))
                        ],
                      )),
                ],
              )
            ],
          ),
          const  SizedBox(height: 100,),
          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Consents ",
                                style: GoogleFonts.inter(
                                  color: AppColors.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                   decoration: TextDecoration.underline
                                )),
                                TextSpan(
                                text: "&",
                                style: GoogleFonts.inter(
                                  color: Color(0xff747171),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  
                                )),
                                TextSpan(
                                text: "Consents ",
                                style: GoogleFonts.inter(
                                  color: AppColors.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline
                                )),
                          ])),

                          const SizedBox(height: 30,),
                          Row(
                            children: [
                           Checkbox(value: false, onChanged: (value){

                           },
                           checkColor: Colors.white,
                           activeColor: AppColors.primaryColor,
                           ),
                              Text(
                    "I confirm I have read, understood and agree to continue.",
                    style: GoogleFonts.inter(
                      color: Color(0xff747171),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),

                            ],
                          ),
                             GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.bottomRight,
              width: 190,
              height: 70,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
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
                  )
                ],
              ),
            ),
          )
        ],

      ),
    );
  }
}
