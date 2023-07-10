import 'package:fackikyc/src/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
body: Container(
width: MediaQuery.of(context).size.width,
height: MediaQuery.of(context).size.height,

child:  Center(

  child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
  SvgPicture.asset("success.svg".imagePath,
            package: "fackikyc",width: 150,height: 150,),
const SizedBox(height: 10,),
    const Text("Successful",style: TextStyle(
      color: Colors.black,
      fontSize: 24
    ),),

    const Padding(
      padding: EdgeInsets.all(25.0),
      child: Text("Your ID verification successful, thank you using Faceki",style: TextStyle(
        color: Colors.black,
        fontSize: 18
      ),),
    ),
  ],),
),

),
    );
  }
}