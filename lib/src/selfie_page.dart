import 'dart:io';

import 'package:camera/camera.dart';
import 'package:facekikyc/src/constant/extension.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../facekikyc.dart';
import 'constant/colors.dart';
import 'constant/app_text_style.dart';

import 'repository.dart';

class SelfiePage extends StatefulWidget {
  const SelfiePage({super.key});
  @override
  State<SelfiePage> createState() => _SelfiePageState();
}

class _SelfiePageState extends State<SelfiePage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;

  int currentCameraIndex = 1;
  @override
  void initState() {
    super.initState();
    if (cameras.isNotEmpty) {
      _initializeCameraController(cameras[currentCameraIndex]);
    } else {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Verify that it’s you",
                style: AppTextStyles.regularColor(
                  fontSize: 24,
                ),
              ),
              const Icon(
                Icons.info_outline,
                color: Colors.black,
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 70,
          ),
          Column(
            children: [
              Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: AspectRatio(
              aspectRatio: (!controller!.value.isInitialized)
                  ? 1 / 1
                  : controller!.value.aspectRatio,
              child: CameraPreview(
                controller!,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white.withOpacity(0.8),
                          width: 170,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          style: BorderStyle.solid),
                      borderRadius: const BorderRadius.all(
                          Radius.elliptical(600, 900))),
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.343,
            bottom: MediaQuery.of(context).size.height * 0.025,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    onTakePictureButtonPressed();
                  },
                  child: SvgPicture.asset(
                    "camera.svg".imagePath,
                    width: 70,
                    height: 70,
                    package: "facekikyc",
                  ),
                ),
                Text(
                  "Take a selfie",
                  style: AppTextStyles.medium(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "More about face verification",
                  style: AppTextStyles.medium(
                      fontSize: 10, color: AppColors.primaryColor),
                )
              ],
            ),
          ),
          Positioned(
            right: 15,
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                if (cameras.length < 2) {
                  return;
                }
                if (currentCameraIndex == 0) {
                  currentCameraIndex = 1;
                } else {
                  currentCameraIndex = 0;
                }
                onNewCameraSelected(cameras[currentCameraIndex]);
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "flip_camera.svg".imagePath,
                    package: "facekikyc",
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    "Flip Camera",
                    style: AppTextStyles.regular(
                      fontSize: 8,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  "footlogo.svg".imagePath,
                  package: "facekikyc",
                  height: 30,
                  width: 50,
                )),
          ),
        ],
              ),
            ],
          )
        ]));
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;

        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      return controller!.setDescription(cameraDescription);
    } else {
      return _initializeCameraController(cameraDescription);
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        final repository = Get.find<Repository>();
        repository.selfieImage = File(file!.path);
        repository.postKyc(context);
      }
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
