library fackikyc;

import 'package:camera/camera.dart';
export 'src/facki_kyc.dart';

 List<CameraDescription> cameras = <CameraDescription>[];

void getCamera()async{

  cameras= await availableCameras();
}

