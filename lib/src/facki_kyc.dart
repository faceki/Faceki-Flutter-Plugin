import 'package:fackikyc/fackikyc.dart';
import 'package:fackikyc/src/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'intro_screen.dart';

class  FackiKyc extends StatefulWidget{
  const FackiKyc({super.key});

  @override
  State<FackiKyc> createState() => _FackiKycState();
}

class _FackiKycState extends State<FackiKyc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   final repository= Get.put(Repository(),permanent: true);
   repository.clientId="2b8tr0234c8aq878vhdap44l63";
   repository.clientSecret="1caci0co3hs8rlc18tj7vbqadrb44nhtu7ipelk0nr4lftf0h5l6";
   repository.getRules();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(

      home: IntroScreen(),
    );
  }

  Future inilizeL(BuildContext context)async{
showDialog(context: context, builder: (context)=> IntroScreen());

  }
}