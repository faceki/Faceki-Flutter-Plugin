import 'dart:io';

import 'package:fackikyc/src/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingPage extends StatelessWidget{

LoadingPage();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
body: Container(
width: MediaQuery.of(context).size.width,
height: MediaQuery.of(context).size.height,
color: Colors.black,
child:  Center(

  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Container(
      //   child: Image.file(face),
      // ),
SvgPicture.asset("loadinginfo.svg"   .imagePath,
            package: "fackikyc",width: 150,height: 150,),
SizedBox(height: 20,),
    Text("Loading...",style: TextStyle(
      color: Colors.white
      ,
      fontSize: 24
    ),)
  ],),
),

),
    );
  }
}