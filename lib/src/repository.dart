import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'loading_page.dart';
import 'succuess_page.dart';
import 'unsuccessful.dart';

class Repository extends GetxController {
  Rx<List<String>> rules = Rx([]);
  List<DocumentType> documentType = [];
  List<String> remainingDoc = [];

  String? clientId;
  String? clientSecret;
  String? selectedIdType;
  String? errorMeaing;
  String? token;
  String? currentType;
  File? selfieImage;
  String baseurl = "sdk.faceki.com";
  Function(Map<String,dynamic>)? onSuccess;
  Function(Map<String,dynamic>)? onError;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future selectedType(String type) async {
    currentType = type;
    remainingDoc.remove(type);
    selectedIdType = type;
  }

  void addSelectedDoc(File frontId, File backId) {
    final type =
        DocumentType(type: currentType, frontImage: frontId, backImage: backId);
    documentType.add(type);
  }

  void setNextDoc() {
    selectedType(remainingDoc.first);
  }

  Future getRules() async {
    try {
      final token = await getToken(clientId!, clientSecret!);
      this.token = token;
      if (token != null) {
        final response = await http
            .get(Uri.parse("https://$baseurl/kycrules/api/kycrules"), headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "Content-Type"
        });

        if (response.statusCode == 200 || response.statusCode == 201) {
          final json = jsonDecode(response.body);
          rules(List.from(json['data']['allowedKycDocuments']));
          remainingDoc = List.from(json['data']['allowedKycDocuments']);
        }
      }
    // ignore: empty_catches
    } catch (ex) {}
  }

  Future<String?> getToken(String clientId, String clientSecret) async {
    try {
      final response = await http.get(Uri.parse(
          "https://$baseurl/auth/api/access-token?clientId=$clientId&clientSecret=$clientSecret"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return json['data']['access_token'];
      }
    // ignore: empty_catches
    } catch (ex) {}
    return null;
  }

  Future postKyc(BuildContext context) async {
    try {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoadingPage()));

      if (token != null) {
        var request = http.MultipartRequest(
            "POST",
            Uri.parse(
                "https://$baseurl/kycverify/api/kycverify/multi-kyc-verification"));

        for (var element in documentType) {
          String? id;
          if (element.type!.contains("ID Card")) {
            id = "id";
          } else if (element.type!.contains("Passport")) {
            id = "pp";
          } else if (element.type!.contains("Driver License")) {
            id = "dl";
          } else {
            id = "";
          }
          request.files.add(
            await http.MultipartFile.fromPath(
                "${id}_front_image", element.frontImage!.path,
                contentType: MediaType('image', 'jpeg')),
          );
          request.files.add(
            await http.MultipartFile.fromPath(
                "${id}_back_image", element.backImage!.path,
                contentType: MediaType('image', 'jpeg')),
          );
        }

        request.files.add(
          await http.MultipartFile.fromPath("selfie_image", selfieImage!.path,
              contentType: MediaType('image', 'jpeg')),
        );

        request.headers.addAll(
            {"Authorization": "Bearer $token", "Content-Type": "Content-Type"});

        var streamResponse = await request.send();
        final result = await http.Response.fromStream(streamResponse);

        final json = jsonDecode(result.body);
        int responseCode = json['responseCode'];
        if (responseCode == 0) {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SuccessPage()),
              ModalRoute.withName('/'));
              if(onSuccess!=null){
              onSuccess!(json);
              }
        } else {

          if (responseCode == 1000) {
            errorMeaing = "Internal System Error";
          } else if (responseCode == 7001) {
            errorMeaing = "No Rules For Company";
          } else if (responseCode == 8001) {
            errorMeaing = "Need Required Images";
          } else if (responseCode == 8002) {
            errorMeaing = "Please try again";
          } else if (responseCode == 8003) {
            errorMeaing = "Face Cropped";
          } else if (responseCode == 8006) {
            errorMeaing = "Face not found";
          } else if (responseCode == 8007) {
            errorMeaing = "Face Closed To Border";
          } else if (responseCode == 8008) {
            errorMeaing = "Face too small";
          } else if (responseCode == 8009) {
            errorMeaing = "Poor Lighting";
          } else if (responseCode == 8010) {
            errorMeaing = "ID Verification Failed";
          } else if (responseCode == 8011) {
            errorMeaing = "Driver Lience Verification Failed";
          } else if (responseCode == 8012) {
            errorMeaing = "Passport Verification Failed";
          } else if (responseCode == 8013) {
            errorMeaing = "Data Not Found";
          } else if (responseCode == 8014) {
            errorMeaing = "Invalid Verification Link";
          } else if (responseCode == 8016) {
            errorMeaing = "Fail To Generate Link";
          } else if (responseCode == 8015) {
            errorMeaing = "Verification Link Expired";
          } else if (responseCode == 8017) {
            errorMeaing = "KYC VERIFICATION LIMIT REACHED";
          } else if (responseCode == 8018) {
            errorMeaing = "SELFIE MULTIPLE FACES";
          } else if (responseCode == 8019) {
            errorMeaing = "FACE BLURR";
          } else {
            errorMeaing = "Unknown issue";
          }

          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => UnSuccessPage()),
              ModalRoute.withName('/'));
                  if(onError!=null){
              onError!(json);
              }
        }
      }
    } catch (ex) {
      errorMeaing = "Error occurred";

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => UnSuccessPage()),
          ModalRoute.withName('/'));
    }
  }
}

class DocumentType {
  String? type;
  File? frontImage;
  File? backImage;

  DocumentType({this.type, this.frontImage, this.backImage});
}
