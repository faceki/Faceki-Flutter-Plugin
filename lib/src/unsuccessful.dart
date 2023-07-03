import 'package:fackikyc/src/constant/extension.dart';
import 'package:fackikyc/src/intro_screen.dart';
import 'package:fackikyc/src/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UnSuccessPage extends StatelessWidget{
final _repository=Get.find<Repository>();
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

   SvgPicture.asset("unsuccess.svg"   .imagePath,
            package: "fackikyc",width: 150,height: 150,),
   SizedBox(height: 10,),
    Text("${_repository.errorMeaing}",style: const TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w700

    ),),
const SizedBox(height: 20,),
    const Padding(
      padding: EdgeInsets.only(left: 24,right: 24),
      child: Text("Couldn’t verify your identity,Please contact us on info@faceki.com",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18
      ),),
    ),
    TextButton(onPressed: (){
      // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
// Navigator.popUntil(context, (route) => MaterialPageRoute(builder: (context)=>IntroScreen()));
// Navigator.pop(context,[false]);
   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                        return IntroScreen();
                     }), (r){
                       return false;
                     });

    }, child: Text("Go back"))
  ],),
),

),
    );
  }
}