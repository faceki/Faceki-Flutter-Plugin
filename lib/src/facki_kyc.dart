import 'package:facekikyc/src/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'intro_screen.dart';

class facekikyc extends StatefulWidget {
  final String clientId;
  final String clientSecret;
 final  Function(Map<String,dynamic>) onSuccess;
 final Function(Map<String,dynamic>) onError;
  const facekikyc(
      {super.key, required this.clientId, required this.clientSecret,required this.onSuccess,required this.onError});

  @override
  State<facekikyc> createState() => _facekikycState();
}

class _facekikycState extends State<facekikyc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final repository = Get.put(Repository(), permanent: true);
    repository.clientId = widget.clientId;
    repository.clientSecret = widget.clientSecret;
    repository.onSuccess=widget.onSuccess;
    repository.onError=widget.onError;
    repository.getRules();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: IntroScreen(),
    );
  }
}
