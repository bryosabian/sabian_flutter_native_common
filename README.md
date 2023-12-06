# sabian_native_common

Common native functions for flutter

Handles common native tasks for Android and IOS.

All permissions related tasks like camera,notifications are handled for you so you only need to
focus on the tasks at hand

# Usage example:

```dart

final _platform = SabianNativeCommon();

void _takePicture(BuildContext context) {
  _platform.media.takePicture().then((payload) {
    _setCurrentImage(payload.images!.first);
    print("Success");
  }).onError((error, stackTrace) {
    print("Error $error");
  });
}

void _choosePicture(BuildContext context) {
  final config = PhotoData()
    ..galleryAlbumName = "Flutter Album"
    ..galleryToolBarTitle = "Choose Photo"
    ..galleryAlbumsTitle = "All Flutter Albums"
    ..cameraTitle = "Take Picture"
    ..allowEditing = true
    ..galleryMaximumPhotos = 3;

  _platform.media.choosePicture(config).then((payload) {
    _setCurrentImage(payload.images!.first);
    print("Success");
  }).onError((error, stackTrace) {
    print("Error $error");
  });
}

void _notify(BuildContext context) {
  final config = NotificationData()
    ..title = "Flutter Notification"
    ..message = "This is a message from the flutter desk. Watch yourself"
    ..canVibrate = true
    ..hasSound = true;
  _platform.notification.notify(config).then((payload) {
    print("Success");
  }).onError((error, stackTrace) {
    print("Error $error");
  });
}

void _getPlatform() {
  _platform.device.getPlatformVersion().then((value) {
    setState(() {
      _platformName = "Platform : ${value ?? "Unknown"}";
    });
  }).onError((error, stackTrace) {
    setState(() {
      _platformName = "Unknown";
    });
  });
}

void _setCurrentImage(Uint8List bytes) {
  setState(() {
    memoryImage = MemoryImage(bytes);
  });
}
```

# Full example below

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sabian_native_common/sabian_native_common.dart';
import 'package:sabian_native_common/structures/notification_data.dart';
import 'package:sabian_native_common/structures/photo_data.dart';
import 'package:sabian_tools/controls/SabianButton.dart';
import 'package:sabian_tools/modals/progress/SabianProgressModal.dart';
import 'package:sabian_tools/toast/SabianToast.dart';
import 'package:sabian_tools/toast/SabianToastType.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _platform = SabianNativeCommon();

  ImageProvider<Object>? _memoryImage;

  final ImageProvider<Object> _assetImage =
  const AssetImage("assets/images/cat2.jpeg");

  SabianProgressModal? _loader;

  String? _platformName;

  @override
  void initState() {
    super.initState();
    _registerSubs();
  }

  @override
  void dispose() {
    _platform.media.events.progress.unRegister();
    super.dispose();
  }

  void _registerSubs() {
    _platform.media.events.progress.onShow = (payload) {
      _loader = SabianProgressModal(
              key: "mProgress",
              title: payload.title ?? "Loading",
              message: payload.message);
      _loader?.show(context, isFull: true);
    };

    _platform.media.events.progress.onHide = (payload) {
      if (_loader != null) {
        _loader!.close(context);
      }
    };

    _platform.media.events.progress.register();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sabian common native app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
                    child: Container(
                            margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
                            child: Text(
                              _platformName ?? "",
                            ))),
            Center(
                    child: SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                              child: Image(
                                image: _memoryImage ?? _assetImage,
                                fit: BoxFit.fill,
                              ),
                            ))),
            FractionallySizedBox(
                    widthFactor: 1,
                    child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SabianButton(
                              text: "Take Picture",
                              textColor: theme.colorScheme.onPrimary,
                              backgroundColor: theme.colorScheme.primary,
                              fontSize: 14,
                              onPressed: () => _takePicture(context),
                            ))),
            FractionallySizedBox(
                    widthFactor: 1,
                    child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SabianButton(
                              text: "Choose Picture",
                              textColor: theme.colorScheme.onPrimary,
                              backgroundColor: theme.colorScheme.primary,
                              fontSize: 14,
                              onPressed: () => _choosePicture(context),
                            ))),
            FractionallySizedBox(
                    widthFactor: 1,
                    child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SabianButton(
                              text: "Notify",
                              textColor: theme.colorScheme.onPrimary,
                              backgroundColor: theme.colorScheme.primary,
                              fontSize: 14,
                              onPressed: () => _notify(context),
                            ))),
            FractionallySizedBox(
                    widthFactor: 1,
                    child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SabianButton(
                              text: "Get Platform",
                              textColor: theme.colorScheme.onPrimary,
                              backgroundColor: theme.colorScheme.primary,
                              fontSize: 14,
                              onPressed: () => _getPlatform(),
                            ))),
          ],
        ),
      ),
    );
  }

  void _takePicture(BuildContext context) {
    _platform.media.takePicture().then((payload) {
      setCurrentImage(payload.images!.first);
      SabianToast("Success ${payload.status}", SabianToastType.success)
              .show(context);
    }).onError((error, stackTrace) {
      SabianToast("Error occurred $error", SabianToastType.danger)
              .show(context);
    });
  }

  void _choosePicture(BuildContext context) {
    final config = PhotoData()
      ..galleryAlbumName = "Flutter Album"
      ..galleryToolBarTitle = "Choose Photo"
      ..galleryAlbumsTitle = "All Flutter Albums"
      ..cameraTitle = "Take Picture"
      ..allowEditing = true
      ..canProcessPermissions = true
      ..galleryMaximumPhotos = 3;

    _platform.media.choosePicture(config).then((payload) {
      setCurrentImage(payload.images!.first);
      SabianToast("Success ${payload.status}", SabianToastType.success)
              .show(context);
    }).onError((error, stackTrace) {
      SabianToast("Error occurred $error", SabianToastType.danger)
              .show(context);
    });
  }

  void _notify(BuildContext context) {
    final config = NotificationData()
      ..title = "Flutter Notification"
      ..message = "This is a message from the flutter desk. Watch yourself"
      ..canVibrate = true
      ..hasSound = true;
    _platform.notification.notify(config).then((payload) {
      SabianToast("Success ${payload.status}", SabianToastType.success)
              .show(context);
    }).onError((error, stackTrace) {
      SabianToast("Error $error", SabianToastType.success).show(context);
    });
  }

  void _getPlatform() {
    _platform.device.getPlatformVersion().then((value) {
      setState(() {
        _platformName = "Platform : ${value ?? "Unknown"}";
      });
    }).onError((error, stackTrace) {
      setState(() {
        _platformName = "Unknown";
      });
    });
  }

  void setCurrentImage(Uint8List bytes) {
    setState(() {
      _memoryImage = MemoryImage(bytes);
    });
  }
}
```

Please see example folder for more usage examples

# Getting Started

# Pubsec.yaml

Add the dependency as shown

```yaml

sabian_native_common:
  path: ../
```

# Android

### Android Manifest 

#### Permissions

Under the android/app/src/main open AndroidManifest.xml and add the following that will be used for the necessary permissions for any native related tasks

Remember to only include the permissions you need 

```xml

<uses-feature android:name="android.hardware.camera" android:required="false" />

<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.CAMERA" />

<application android:name="${applicationName}" android:icon="@mipmap/ic_launcher"
android:label="sabian_native_common_example">


<!--...... the rest goes here -->
</application>
```

### Add xml/provider_paths.xml

If you don't need to use picture or any media related activity, ignore the following 2 instructions.

Otherwise, under the android/app/src/main/res folder create 'xml' folder. Under which, create
provider_paths.xml and add the following:

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths>
    <external-path name="external_files" path="." />
</paths>
```

Afterwards, under the android/app/src/main, open AndroidManifest.xml and add the following provider path xml code under the <application> tag as shown
```xml
<application android:name="${applicationName}" android:icon="@mipmap/ic_launcher"
    android:label="sabian_native_common_example">
  <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="${applicationId}.provider"

            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/provider_paths" />
        </provider>

    <!--...... the rest goes here -->
</application>
```

### MainActivity

If you don't need to use picture or any media related activity, ignore this.

Otherwise, before editing the main activity, build the project.

After building, under the android/app/src/main/kotlin/your_package_directory folder, open MainActivity and extend MediaActivity as shown

```kotlin
package com.sabiantech.sabian_native_common_example

import com.sabiantech.sabian_native_common.utilities.media.MediaActivity

class MainActivity : MediaActivity()
```

Build the flutter project. You are all set for Android

# IOS

### Register permissions
If you wish the plug in to handle permissions for you, do the following. Otherwise, ignore the following instructions:

#### Import Permission Libraries
Under the ios folder, open the Podfile and add the following permission handlers under target project

Remember to only include the permissions you need otherwise your app will be flagged by Apple and you may need to explain the need of all those permissions.
For a list of all supported permissions, see https://cocoapods.org/pods/SPPermissions

```ruby
pod 'SPPermissions/Camera'
pod 'SPPermissions/PhotoLibrary'
pod 'SPPermissions/Notification'
 ```

e.g
```ruby
target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
  
  pod 'SPPermissions/Camera'
  pod 'SPPermissions/PhotoLibrary'
  pod 'SPPermissions/Notification'
  
  #Add all permissions related dependancies here using SPPermissions/
  #More see https://cocoapods.org/pods/SPPermissions
  
  target 'RunnerTests' do
    inherit! :search_paths
  end
end

#rest goes here
```

#### Library permissions
Under the sabian_native_common/ios directory, open ios/Classes folder and click SabianNativePermissionsList.swift and uncomment the permissions you need based on the specified permissions above
e.g

```swift
import Foundation
import SPPermissions

class SabianNativePermissionsList {
    static var permissions : Dictionary<String,SPPermissions.Permission> {
        var permissions = Dictionary<String,SPPermissions.Permission>()
        //permissions["Camera"] = SPPermissions.Permission.camera
        //permissions["Notification"] = SPPermissions.Permission.notification
        //permissions["Photo Library"] = SPPermissions.Permission.photoLibrary
        return permissions
    }
}
```

Current supported permissions are
- Camera
- Notification
- PhotoLibrary

#### Describe permissions
Last but not the least, developing for IOS requires you give a description of how you intend to use certain permissions in your application
In order to use the needed/required permissions, do the following

Open Xcode and edit the info.plist file inside the ios folder and add the following keys with their values.
The value will correspond to the description on how you intend to use the corresponding permission:

```text
Privacy - Camera Usage Description
Privacy - Photo Library Usage Description
Privacy - Media Library Usage Description
```

Close xcode and build the flutter project

You're all set for IOS

# Screens

![alt text](https://github.com/bryosabian/sabian_flutter_native_common/assets/16384340/3bfcfcc6-2627-4383-9bfa-619697d06193)

![alt text](https://github.com/bryosabian/sabian_flutter_native_common/assets/16384340/b005e726-f87b-44eb-8ee1-09932046af2b)

# Scope
Current supported tasks are
- Device
  - Get Platform Version
- Media
  - Take Picture
  - Choose from Gallery
- Notification
  - Post notifications

More coming soon

# Libraries Used
- Android Image Picker (Android) : https://github.com/esafirm/android-image-picker
- Dexter Permissions (Android) : https://github.com/Karumi/Dexter
- SPPermissions (IOS) : https://cocoapods.org/pods/SPPermissions
- YPImagePicker (IOS) : https://github.com/Yummypets/YPImagePicker