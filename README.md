<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->


V1.1 Stable version | Release Date: 20/07/2023 

## Installation

First, add `facekikyc: ^1.0.0` as a
[dependency in your pubspec.yaml file]

### iOS Setup
Add the following keys to your _Info.plist_ file, located in
`<project root>/ios/Runner/Info.plist`:

* `NSPhotoLibraryUsageDescription` - describe why your app needs permission for
the photo library. This is called _Privacy - Photo Library Usage Description_ in
the visual editor.
  * This permission will not be requested if you always pass `false` for
  `requestFullMetadata`, but App Store policy requires including the plist
  entry.
* `NSCameraUsageDescription` - describe why your app needs access to the camera.
This is called _Privacy - Camera Usage Description_ in the visual editor.

### Android Setup
Add this permission to your AndroidManifest.xml  File

 * `<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>`
 * `<uses-permission android:name="android.permission.INTERNET" />`
## Getting Started

You can get your client id and client secret using the portal. Here is a guide which will help you setup your account:

* https://kycdocv2.faceki.com/quick-guides/verification-settings

* https://kycdocv2.faceki.com/quick-guides/integration-setting

## Usage



```dart

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: facekikyc(
        clientId: "your-client-key",
        clientSecret: "your-client-secret",
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
```


