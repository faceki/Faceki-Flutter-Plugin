import 'dart:io';

import 'package:camera/camera.dart';
import 'package:example/constant/colors.dart';
import 'package:example/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'constant/app_text_style.dart';
import 'main.dart';

class SelfiePage extends StatefulWidget {
  File frontId;
  File backId;
  SelfiePage({required this.frontId, required this.backId});
  @override
  State<SelfiePage> createState() => _SelfiePageState();
}

class _SelfiePageState extends State<SelfiePage>     with WidgetsBindingObserver, TickerProviderStateMixin{

    CameraController? controller;
  XFile? imageFile;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  double _minAvailableZoom = 0.5;
  double _maxAvailableZoom = 0.5;
  double _currentScale = 0.5;
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
    // TODO: implement build

    return Material(
        child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 70,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          Text(
            "Verify that it’s you",
            style: AppTextStyles.regularColor(fontSize: 24),
          ),
          const Icon(
            Icons.info_outline,
            color: Colors.black,
          )
        ],
      ),
      Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage(
              //       "assets/images/imagefront.jpg",
              //     ),
              //     fit: BoxFit.cover),
              // border: Border.all(
              //     color: const Color(0xff7B7B7B), width: 0)
            ),
            child: CameraPreview(
                    controller!,
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onScaleStart: _handleScaleStart,
                        onScaleUpdate: _handleScaleUpdate,
                        onTapDown: (TapDownDetails details) =>
                            onViewFinderTap(details, constraints),
                      );
                    }),
                  ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.2,
            top: (MediaQuery.of(context).size.height * 0.55) / 9,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration:
                  BoxDecoration(border: Border.all(color: Color(0xff7B7B7B)),
                  borderRadius: BorderRadius.circular(200)
                  ),
                  
              // child: Image.asset(
              //   "assets/images/imagefront.jpg",
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.38,
            bottom: 20,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    onTakePictureButtonPressed();
                  },
                  child: SvgPicture.asset(
                    "assets/images/camera.svg",
                    width: 100,
                    height: 100,
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
                          fontSize: 10,
                          color: AppColors.primaryColor
                        ),
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
                          "assets/images/flip_camera.svg",
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
               child: Container
                       (
                         alignment: Alignment.bottomLeft,
                         margin: EdgeInsets.only(left: 10),
                         child: SvgPicture.asset("assets/images/footlogo.svg",height: 30,width: 50,)),
             ),
        ],
      )
    ])));
  }
  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: false,
      // imageFormatGroup: ImageFormatGroup.jpeg,
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

Repository.postKyc(clientId: "78pvad5glu20qccgmdcps7nb0d", clientSecret: "vbhqvnmmq393b9sup7ftcrfdpn5bsu527tq9f24b8i6uf2m3li9", frontId: widget.frontId, backId: widget.backId, faceId: File(file!.path));
        if (file != null) {
          // Get.to(FrontPageResult(file: File(file!.path)));
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
