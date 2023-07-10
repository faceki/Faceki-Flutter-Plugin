import 'dart:io';

import 'package:camera/camera.dart';
import 'package:facekikyc/src/constant/extension.dart';
import 'package:facekikyc/src/repository.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'back_page_result.dart';
import '../constant1/app_text_style.dart';
import '../constant1/colors.dart';

import '../facekikyc.dart';

class BackPageDocument extends StatefulWidget {
 final File frontCard;
  const BackPageDocument({super.key, required this.frontCard});
  @override
  State<BackPageDocument> createState() => _BackPageDocumentState();
}

class _BackPageDocumentState extends State<BackPageDocument>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;



  int currentCameraIndex = 0;
  final _repository = Get.find<Repository>();
  @override
  void initState() {

    super.initState();
    if (cameras.isNotEmpty) {
      _initializeCameraController(cameras[currentCameraIndex]);
    } else {
      showInSnackBar('Camera is not available');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
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
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
              Text(
                "Verify your identity",
                style: AppTextStyles.regularColor(fontSize: 24),
              ),
              const Icon(
                Icons.info_outline,
                color: Colors.black,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "You'll need to take a photo of your ${_repository.selectedIdType}.",
              style: AppTextStyles.regular(
                fontSize: 18,
                color: const Color(0xff585858),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "BACK SIDE",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xff7B7B7B), width: 0)),
                  child: (controller == null)
                      ? const Text("No camera available")
                      : (!controller!.value.isInitialized)
                          ? const Text("Initializing camera")
                          : ClipRect(
                              child: OverflowBox(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    height: 1,
                                    child: AspectRatio(
                                      aspectRatio:
                                          1 / controller!.value.aspectRatio,
                                      child: CameraPreview(controller!),
                                    ),
                                  ),
                                ),
                              ),
                            )),
            ],
          ),
          const SizedBox(
            height: 70,
          ),
          Center(
              child: Text(
            "We'll ask you to enable camera access",
            style: AppTextStyles.regular(
              fontSize: 16,
            ),
          )),
          Center(
              child: Text(
            "More about verification",
            style: AppTextStyles.regular(
              fontSize: 16,
              color: AppColors.primaryColor,
            ),
          )),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
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
                      width: 25,
                      height: 25,
                    ),
                    Text(
                      "Flip Camera",
                      style: AppTextStyles.regular(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTakePictureButtonPressed();
                },
                child: SvgPicture.asset(
                  "camera.svg".imagePath,
                  package: "facekikyc",
                  width: 70,
                  height: 70,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();

                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BackPageResult(
                                  file: File(image.path),
                                  frontFile: widget.frontCard,
                                )));
                  }
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "choosefile.svg".imagePath,
                      package: "facekikyc",
                      width: 25,
                      height: 25,
                    ),
                    Text(
                      "Upload Document",
                      style: AppTextStyles.regular(
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Expanded(
            child: SizedBox(
            
                ),
          ),
          Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(
                "footlogo.svg".imagePath,
                package: "facekikyc",
                height: 30,
                width: 50,
              )),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
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

    // If the controller is updated then update the UI.
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
      await Future.wait(<Future<Object?>>[
        cameraController.getMaxZoomLevel().then((double value) {
             cameraController.setZoomLevel(value - 1);
             return null;
        }),

      ]);
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

        if (file != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BackPageResult(
                        file: File(file.path),
                        frontFile: widget.frontCard,
                      )));
        }
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
