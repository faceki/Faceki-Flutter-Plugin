import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:fackikyc/src/constant/extension.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../fackikyc.dart';
import 'constant/app_text_style.dart';
import 'constant/colors.dart';

import 'front_page_result.dart';

import 'verify_document.dart';

class FrontPageDocument extends StatefulWidget {
  @override
  State<FrontPageDocument> createState() => _FrontPageDocumentState();
}

class _FrontPageDocumentState extends State<FrontPageDocument>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  double _minAvailableZoom = 2.0;
  double _maxAvailableZoom = 2.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  int _pointers = 0;
  int currentCameraIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (cameras.isNotEmpty) {
      _initializeCameraController(cameras[currentCameraIndex]);
    } else {
      print("camera is null");
     availableCameras().then((value){

cameras=value;
 _initializeCameraController(cameras[currentCameraIndex]);
setState(() {
  
});
     });

      // showInSnackBar('Camera is not available');
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

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  @override
  Widget build(BuildContext context) {
      //  controller!.setZoomLevel(1.0);
      //  controller!.setExposurePoint(Offset(0, 0));
       
    // TODO: implement build
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
                onTap: (){
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
              "You'll need to take a photo of your ID.",
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
                    "FRONT SIDE",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xff7B7B7B), width: 0)),
                child:(controller==null)?Text("No camera available"): CameraPreview(
                  controller!,
                  // child: LayoutBuilder(builder:
                  //     (BuildContext context, BoxConstraints constraints) {
                  //   return GestureDetector(
                  //     behavior: HitTestBehavior.opaque,
                  //     onScaleStart: _handleScaleStart,
                  //     onScaleUpdate: _handleScaleUpdate,
                  //     onTapDown: (TapDownDetails details) =>
                  //         onViewFinderTap(details, constraints),
                  //   );
                  // }),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
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
                      "flip_camera.svg"   .imagePath,
          package: "fackikyc",
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
                  "camera.svg"   .imagePath,
          package: "fackikyc",
                  width: 70,
                  height: 70,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();

                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                if(image!=null){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>
      FrontPageResult(file: File(image.path))));
                }      
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "choosefile.svg"   .imagePath,
          package: "fackikyc",
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
                // height: 100,
                ),
          ),
          Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(
                "footlogo.svg"   .imagePath,
          package: "fackikyc",
                height: 30,
                width: 50,
              )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    
    final CameraController cameraController = CameraController(
      cameraDescription,
   ResolutionPreset.medium, 
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
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
                cameraController.getMinExposureOffset().then(
                    (double value) => _minAvailableExposureOffset = value),
                cameraController
                    .getMaxExposureOffset()
                    .then((double value) => _maxAvailableExposureOffset = value)
              ]
            : <Future<Object?>>[],
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);
      // print("minimum zoom level is $_minAvailableZoom");
      // print("maximum zoom level is $_maxAvailableZoom");
   
    } on CameraException catch (e) {
      print("error initizlize camera ${e.code}");
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
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
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
          // videoController?.dispose();
          // videoController = null;
        });

        if (file != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
        FrontPageResult(file: File(file!.path))));
          print("file path ${file.path}");
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
    // _logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
