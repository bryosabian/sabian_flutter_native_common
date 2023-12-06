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
