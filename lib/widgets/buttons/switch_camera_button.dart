import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SwitchCameraButton extends StatelessWidget {
  const SwitchCameraButton({super.key, required this.controller});

  final MobileScannerController controller;
  Future<void> _onPressed() async => controller.switchCamera();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (ctx, state, _) {
          if (!state.isInitialized || !state.isRunning) {
            return const SizedBox.shrink();
          }

          final availableCameras = state.availableCameras;

          if (availableCameras != null && availableCameras < 2) {
            return const SizedBox.shrink();
          }

          final Widget icon;

          switch (state.cameraDirection) {
            case CameraFacing.front:
              icon = const Icon(Icons.camera_front);
            case CameraFacing.back:
              icon = const Icon(Icons.camera_rear);
          }

          return IconButton(
            color: Colors.white,
            iconSize: 22,
            icon: icon,
            onPressed: _onPressed,
          );
        });
  }
}
