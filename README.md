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

<!-- TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them. -->



<!-- ## Getting started -->


## Installation

First, add `fackikyc` as a
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

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const FackiKyc(clientId: "2b8tr0234c8aq878vhdap44l63",clientSecret: "1caci0co3hs8rlc18tj7vbqadrb44nhtu7ipelk0nr4lftf0h5l6",),
    );
  }
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
