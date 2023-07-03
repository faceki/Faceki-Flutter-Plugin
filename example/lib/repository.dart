import 'dart:convert';
import 'dart:io';

import 'package:example/loading_page.dart';
import 'package:example/succuess_page.dart';
import 'package:example/unsuccessful.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class Repository{

static Future<String?> getToken(String clientId, String clientSecret)async{
try{
final response = await http.get(Uri.parse("https://apidev.facechain.org/auth/api/access-token?clientId=$clientId&clientSecret=$clientSecret"));

if(kDebugMode){

  print("response is here ${response.body}");

}

if(response.statusCode==200 || response.statusCode==201){
final json=jsonDecode(response.body);
return json['data']['access_token'];

}
}catch(ex){


}


}
static Future postKyc({required String clientId, required String clientSecret, required File frontId, required File backId, required File faceId})async{
try{
Get.to(LoadingPage());
String? token=await getToken(clientId, clientSecret);
if(token!=null){

     var request = http.MultipartRequest("POST", Uri.parse("https://apidev.facechain.org/kycverify/api/kycverify/kyc-verification"));

    request.files.add(
          await http.MultipartFile.fromPath("selfie_image", faceId.path,
              contentType: MediaType('image', 'jpeg')),
        );
 request.files.add(
          await http.MultipartFile.fromPath("doc_front_image", backId.path,
              contentType: MediaType('image', 'jpeg')),
        );
 request.files.add(
          await http.MultipartFile.fromPath("doc_back_image", frontId.path,
              contentType: MediaType('image', 'jpeg')),
        );

   request.headers.addAll({

    "Authorization":"Bearer $token",
    "Content-Type":"Content-Type"
   });
      //print("request is ${request.fields.toString()}");
      var streamResponse = await request.send();
      String result = await streamResponse.stream.transform(const Utf8Decoder()).single;
      print("result is respons eis $result");
final json=jsonDecode(result);
int responseCode=json['responseCode'];
if(responseCode==0){
Get.to(SuccessPage());
}else{

  Get.to(UnSuccessPage());
}

}

}catch(ex){
  Get.to(UnSuccessPage());

}


}


}