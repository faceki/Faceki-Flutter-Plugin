import 'package:carousel_slider/carousel_slider.dart';
import 'package:fackikyc/src/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../fackikyc.dart';
import 'choose_document.dart';

import 'constant/app_text_style.dart';
import 'constant/colors.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Widget> imagelist = [];
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    // super.initState();
    getCamera();
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    imagelist = [
      itemCarousel("id0.png", "Document Scan",
          "Will ask you to take a picture of your document"),
      itemCarousel("idc.png", "Verify Scan",
          "Data will be stored and may be used accoring to the Stripe Privacy and the Rocket Rides Privacy Policy"),
      itemCarousel("id2.svg", "Take Selfie",
          "Data will be stored and may be used accoring to the Stripe Privacy and the Rocket Rides Privacy Policy"),
    ];
    // TODO: implement build
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            SvgPicture.asset(
              "logo_faceki.svg".imagePath,
              package: "fackikyc",
              height: 40,
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
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
              aspectRatio: 1.1,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              initialPage: 0,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
              items: imagelist,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imagelist.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChooseDocument()));
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
                            const Icon(
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
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget itemCarousel(String imagePath, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (imagePath.contains("svg"))
            ? SvgPicture.asset(imagePath.imagePath,
                package: "fackikyc",
                height: MediaQuery.of(context).size.height * 0.3)
            : Image.asset(
                imagePath.imagePath,
                package: "fackikyc",
                height: MediaQuery.of(context).size.height * 0.3,
              ),

        Text(
          title,
          style: GoogleFonts.inter(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
        ),

        Text(
          description,
          style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
// SizedBox(height: 24,)
      ],
    );
  }
}
