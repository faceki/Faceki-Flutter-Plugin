library fackikyc;

import 'package:camera/camera.dart';
export 'src/facki_kyc.dart';

 List<CameraDescription> cameras = <CameraDescription>[];
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
void getCamera()async{

  cameras= await availableCameras();
}

