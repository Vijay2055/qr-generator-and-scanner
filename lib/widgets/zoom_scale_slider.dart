import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ZoomScaleSlider extends StatelessWidget {
  const ZoomScaleSlider({super.key, required this.controller});
  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (ctx, state, _) {
          if (!state.isInitialized || !state.isRunning) {
            return const SizedBox.shrink();
          }

          final double zoomScale = state.zoomScale.clamp(0.1, 1.0);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    controller
                        .setZoomScale((state.zoomScale - 0.1).clamp(0.1, 1.0));
                  },
                  icon: const Icon(Icons.zoom_out),
                ),
                Expanded(
                  child: Slider(
                    value: zoomScale,
                    min: 0.1,
                    max: 1.0,
                    onChanged: (value) {
                      controller.setZoomScale(value);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.zoom_in),
                  onPressed: () {
                    controller
                        .setZoomScale((state.zoomScale + 0.1).clamp(0.1, 1.0));
                  },
                ),
              ],
            ),
          );
        });
  }
}
