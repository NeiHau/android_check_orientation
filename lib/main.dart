import 'dart:io';

import 'package:android_check_orientation/autorotation.dart';
import 'package:android_check_orientation/device_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 画面が縦向きであるかどうか。
  bool _isPortrait = true;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return NativeDeviceOrientationReader(
          useSensor: true,
          builder: (context) {
            checkOrientationStatus(context);

            return Center(
              child: FloatingActionButton.extended(
                onPressed: _changeOrientation,
                label: const Text("画面回転"),
              ),
            );
          },
        );
      },
    );
  }

  void checkOrientationStatus(context) async {
    int? autoRotationStatus;

    if (Platform.isAndroid) {
      await AutoRotation.autoRotation();
    }

    //final orientation = NativeDeviceOrientationReader.orientation(ctx);

    // if (Platform.isIOS || autoRotationStatus != 0) {
    //   if (MediaQuery.of(context).orientation == Orientation.landscape) {
    //     if (orientation == NativeDeviceOrientation.portraitUp ||
    //         orientation == NativeDeviceOrientation.portraitDown) {
    //       SystemChrome.setPreferredOrientations([
    //         DeviceOrientation.portraitUp,
    //         DeviceOrientation.portraitDown,
    //         DeviceOrientation.landscapeLeft,
    //         DeviceOrientation.landscapeRight,
    //       ]);
    //     }
    //   }
    //
    //   if (MediaQuery.of(context).orientation == Orientation.portrait) {
    //     if (orientation == NativeDeviceOrientation.landscapeRight ||
    //         orientation == NativeDeviceOrientation.landscapeLeft) {
    //       SystemChrome.setPreferredOrientations([
    //         DeviceOrientation.portraitUp,
    //         DeviceOrientation.portraitDown,
    //         DeviceOrientation.landscapeLeft,
    //         DeviceOrientation.landscapeRight,
    //       ]);
    //     }
    //   }
    // }
  }

  void _changeOrientation() {
    _isPortrait = !_isPortrait;
    if (_isPortrait) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    } else {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
  }
}
