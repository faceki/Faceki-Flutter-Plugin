import 'package:facekikyc/facekikyc.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: facekikyc(
        clientId: "2b8tr0234c8aq878vhdap44l63",
        clientSecret: "1caci0co3hs8rlc18tj7vbqadrb44nhtu7ipelk0nr4lftf0h5l6",
        onSuccess: (po) {
          // action to be done
          print("success response is $po");
        },
        onError: (po) {
// action to be done
          print("error response is $po");
        },
      ),
    );
  }
}
