import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UnSuccessPage extends StatelessWidget{

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

   SvgPicture.asset("assets/images/unsuccess.svg",width: 150,height: 150,),
   SizedBox(height: 10,),
    Text("Extra Verification Required",style: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w700

    ),),
SizedBox(height: 20,),
    Padding(
      padding: EdgeInsets.only(left: 24,right: 24),
      child: Text("Couldn’t verify your identity,Please contact us on info@faceki.com",
      textAlign: TextAlign.center,
      style: TextStyle(
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