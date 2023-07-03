import 'package:fackikyc/src/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
body: Container(
width: MediaQuery.of(context).size.width,
height: MediaQuery.of(context).size.height,
// color: Colors.black,
child:  Center(

  child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
  SvgPicture.asset("success.svg".imagePath,
            package: "fackikyc",width: 150,height: 150,),

    Text("Successful",style: TextStyle(
      color: Colors.white,
      fontSize: 24
    ),),

    Text("Your ID verification successful, thank you using Faceki",style: TextStyle(
      color: Colors.white,
      fontSize: 18
    ),),
  ],),
),

),
    );
  }
}