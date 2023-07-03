import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fackikyc/src/constant/extension.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../fackikyc.dart';
import 'constant/colors.dart';
import 'constant/app_text_style.dart';

import 'repository.dart';


class SelfiePage extends StatefulWidget {

  SelfiePage();
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
  int currentCameraIndex = 1;
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
// controller!.setFocusPoint(Offset(0.5, 0.5));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // GestureDetector(
                                  //   onTap: () => Navigator.pop(context),
                                  //   child: const Icon(
                                  //     Icons.arrow_back_rounded,
                                  //    color: Colors.black,
                                  //   ),
                                  // ),
                                  Text(
                                    "Verify that it’s you",
                                    style: AppTextStyles.regularColor(fontSize: 24,),
                                  ),
                                  const Icon(
                                    Icons.info_outline,
                                    color: Colors.black,
                                  )
                                ],
                              ),
        
      ),
      backgroundColor: Colors.white,
        body: Container(

            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                decoration: BoxDecoration(
                  color: Colors.black,  
                  //  border: Border.all(color: Color(0xff7B7B7B)),
                  //                borderRadius: new BorderRadius.all(Radius.elliptical(550, 800))

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
                  child: Container(
                    decoration: BoxDecoration(
                                //  color: Colors.grey.withOpacity(0.8),
                                 border: Border.all(color: Colors.white.withOpacity(0.8),width: 170,strokeAlign: BorderSide.strokeAlignCenter,style: BorderStyle.solid),
                                 borderRadius: new BorderRadius.all(Radius.elliptical(600, 900))
                                // borderRadius: BorderRadius.all( Radius.circular(250) )

                          ),
                    // child:Stack(
                    //   children: [
                    //       Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //             children: [
                    //               GestureDetector(
                    //                 onTap: () => Navigator.pop(context),
                    //                 child: const Icon(
                    //                   Icons.arrow_back_rounded,
                    //                  color: Colors.black,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 "Verify that it’s you",
                    //                 style: AppTextStyles.regularColor(fontSize: 24,),
                    //               ),
                    //               const Icon(
                    //                 Icons.info_outline,
                    //                 color: Colors.black,
                    //               )
                    //             ],
                    //           ),
                    //   ],
                    // ) 
                    //
                    // Center(
                    //         child: Container(
                    //           width: MediaQuery.of(context).size.width * 0.6,
                    //           height: MediaQuery.of(context).size.height * 0.45,
                    //           decoration:
                    //               BoxDecoration(
                    //                 color: Colors.transparent,
                    //                 border: Border.all(color: Color(0xff7B7B7B)),
                    //              borderRadius: new BorderRadius.all(Radius.elliptical(550, 800)
                    //               )),
                    //               // child: CameraPreview(
                    //               //           controller!),
                                
                    //           // child: Image.asset(
                    //           //   "assets/images/imagefront.jpg",
                    //           //   fit: BoxFit.cover,
                    //           // ),
                    //         ),
                    //       ),
                  ),
                ),
              ),
              // Positioned(
              //   left: MediaQuery.of(context).size.width * 0.2,
              //   top: (MediaQuery.of(context).size.height * 0.55) / 6,
              //   child: ClipOval(
              //     child: Container(
              //       width: MediaQuery.of(context).size.width * 0.65,
              //       height: MediaQuery.of(context).size.height * 0.4,
              //       // decoration:
              //       //     BoxDecoration(border: Border.all(color: Color(0xff7B7B7B)),
              //       //     borderRadius: BorderRadius.circular(500)
              //       //     ),
                      
              //       // child: Image.asset(
              //       //   "assets/images/imagefront.jpg",
              //       //   fit: BoxFit.cover,
              //       // ),
              //     ),
              //   ),
              // ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.343,
                bottom: MediaQuery.of(context).size.height*0.025,
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
                           package: "fackikyc",
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
                              "flip_camera.svg"   .imagePath,
                package: "fackikyc",
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
                             child: SvgPicture.asset("footlogo.svg"   .imagePath,
                package: "fackikyc",height: 30,width: 50,)),
                 ),
            ],
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
final _repository=Get.find<Repository>();
_repository.selfieImage=File(file!.path);
_repository.postKyc();
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
