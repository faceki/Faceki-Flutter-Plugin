import 'package:facekikyc/src/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1300,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    animation = Tween<double>(begin: 0.9, end: 3).animate(animationController!)
      ..addListener(() {
        setState(() {});
      });
    animationController!.repeat(reverse: false);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xff343333),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(
                scale: animation!.value,
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: SvgPicture.asset(
                      "loadinginfo.svg".imagePath,
                      package: "facekikyc",
                      width: 150,
                      height: 150,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Loading...",
                style: TextStyle(color: Colors.white, fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
