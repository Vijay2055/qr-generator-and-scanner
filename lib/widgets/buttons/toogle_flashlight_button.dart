import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ToogleFlashlightButton extends StatelessWidget {
  const ToogleFlashlightButton({super.key, required this.controller});

  Future<void> onPress() async => controller.toggleTorch();

  final MobileScannerController controller;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (ctx, state, _) {
          if (!state.isInitialized || !state.isRunning) {
            return const SizedBox.shrink();
          }

          switch (state.torchState) {
            case TorchState.auto:
              return IconButton(
                iconSize: 22,
                color: Colors.white,
                onPressed: onPress,
                icon: const Icon(Icons.flash_auto),
              );
            case TorchState.on:
              return IconButton(
                iconSize: 22,
                color: Colors.white,
                onPressed: onPress,
                icon: const Icon(Icons.flash_on),
              );

            case TorchState.off:
              return IconButton(
                iconSize: 22,
                color: Colors.white,
                onPressed: onPress,
                icon: const Icon(Icons.flash_off),
              );
            case TorchState.unavailable:
              return const SizedBox.square(
                dimension: 48,
                child: Icon(
                  Icons.no_flash,
                  size: 22,
                  color: Colors.grey,
                ),
              );
          }
        });
  }
}
