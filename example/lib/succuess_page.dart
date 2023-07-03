import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
body: Container(
width: MediaQuery.of(context).size.width,
height: MediaQuery.of(context).size.height,
// color: Colors.black,
child: const Center(

  child: Column(children: [


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