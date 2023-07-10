import 'package:fackikyc/fackikyc.dart';
import 'package:fackikyc/src/loading_page.dart';
import 'package:fackikyc/src/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'intro_screen.dart';

class  FackiKyc extends StatefulWidget{
  final String clientId;
  final String clientSecret;
  const FackiKyc({super.key, required this.clientId,required this.clientSecret});

  @override
  State<FackiKyc> createState() => _FackiKycState();
}

class _FackiKycState extends State<FackiKyc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   final repository= Get.put(Repository(),permanent: true);
   repository.clientId=widget.clientId;
   repository.clientSecret=widget.clientSecret;
   repository.getRules();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: 
     
      IntroScreen(),
    );
  }


}