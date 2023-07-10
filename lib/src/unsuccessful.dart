import 'package:facekikyc/src/constant/extension.dart';
import 'package:facekikyc/src/intro_screen.dart';
import 'package:facekikyc/src/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UnSuccessPage extends StatelessWidget {
  final _repository = Get.find<Repository>();

   UnSuccessPage({super.key});
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "unsuccess.svg".imagePath,
                package: "facekikyc",
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${_repository.errorMeaing}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Text(
                  "Couldn’t verify your identity,Please contact us on info@faceki.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const IntroScreen();
                    }), (r) {
                      return false;
                    });
                  },
                  child: const Text("Go back"))
            ],
          ),
        ),
      ),
    );
  }
}
