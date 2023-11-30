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
  final config = PhotoConfig()
    ..galleryAlbumName = "Flutter Album"
    ..galleryToolBarTitle = "Choose Photo"
    ..galleryAlbumsTitle = "All Flutter Albums"
    ..cameraTitle = "Take Picture"
    ..allowEditing = true
    ..galleryMaximumPhotos = 3;

  _platform.media.choosePicture(config: config).then((payload) {
    _setCurrentImage(payload.images!.first);
    print("Success");
  }).onError((error, stackTrace) {
    print("Error $error");
  });
}

void _notify(BuildContext context) {
  final config = NotificationConfig()
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
import 'package:sabian_native_common/structures/sabian_notification_config.dart';
import 'package:sabian_native_common/structures/sabian_photo_config.dart';
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

  ImageProvider<Object>? memoryImage;

  ImageProvider<Object> assetImage =
  const AssetImage("assets/images/cat2.jpeg");

  SabianProgressModal? loader;

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
      loader = SabianProgressModal(
          key: "mProgress",
          title: payload.title ?? "Loading",
          message: payload.message);
      loader?.show(context, isFull: true);
    };

    _platform.media.events.progress.onHide = (payload) {
      if (loader != null) {
        loader!.close(context);
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
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                      child: Image(
                        image: memoryImage ?? assetImage,
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
                    )))
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
    final config = PhotoConfig()
      ..galleryAlbumName = "Flutter Album"
      ..galleryToolBarTitle = "Choose Photo"
      ..galleryAlbumsTitle = "All Flutter Albums"
      ..cameraTitle = "Take Picture"
      ..allowEditing = true
      ..galleryMaximumPhotos = 3;

    _platform.media.choosePicture(config: config).then((payload) {
      setCurrentImage(payload.images!.first);
      SabianToast("Success ${payload.status}", SabianToastType.success)
          .show(context);
    }).onError((error, stackTrace) {
      SabianToast("Error occurred $error", SabianToastType.danger)
          .show(context);
    });
  }

  void _notify(BuildContext context) {
    final config = NotificationConfig()
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

  void setCurrentImage(Uint8List bytes) {
    setState(() {
      memoryImage = MemoryImage(bytes);
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

Under the android/app/src/main open AndroidManifest.xml and add the following that will be used for the necessary permissions and provider paths for any native related tasks

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

<provider android:name="androidx.core.content.FileProvider"
    android:authorities="${applicationId}.provider"

    android:grantUriPermissions="true">
    <meta-data android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/provider_paths" />
</provider>
<!--...... the rest goes here -->
</application>
```

### Add xml/provider_paths.xml

If you don't need to use picture or any media related activity, ignore this.

Otherwise, under the android/app/src/main/res folder create 'xml' folder. Under which, create
provider_paths.xml and add the following:

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths>
    <external-path name="external_files" path="." />
</paths>
```

### MainActivity

If you don't need to use picture or any media related activity, ignore this.

Otherwise, before editing the main activity, build the project.

After building, open MainActivity and extend MediaActivity as shown

```kotlin
package com.sabiantech.sabian_native_common_example

import com.sabiantech.sabian_native_common.utilities.media.MediaActivity

class MainActivity : MediaActivity()
```

Build the flutter project. You are all set for Android

# IOS

### Register permissions
Developing for IOS requires you give a description of how you intend to use certain permissions in your application
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

