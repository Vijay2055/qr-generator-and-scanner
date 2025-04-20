import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:qr_scanner/overlays/scan_window_overlay.dart';
import 'package:qr_scanner/providers/scan_state.dart';
import 'package:qr_scanner/utilities/getFomatedDate.dart';
import 'package:qr_scanner/utility/uint_to_file.dart';
import 'package:qr_scanner/widgets/buttons/analyze_image_button.dart';
import 'package:qr_scanner/widgets/buttons/switch_camera_button.dart';
import 'package:qr_scanner/widgets/buttons/toogle_flashlight_button.dart';
import 'package:qr_scanner/widgets/drawer_menu.dart';
import 'package:qr_scanner/widgets/scanner_exception_widget.dart';
import 'package:qr_scanner/screens/scanned_data_screen.dart';
import 'package:qr_scanner/widgets/zoom_scale_slider.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class QrScanner extends ConsumerStatefulWidget {
  const QrScanner({super.key});
  @override
  ConsumerState<QrScanner> createState() {
    return _QrScannerState();
  }
}

class _QrScannerState extends ConsumerState<QrScanner> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  static const useScanWindow = true;
  bool useBarcodeOverlay = true;

  late MobileScannerController _mobileScannerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: true,
      torchEnabled: false,
    );
  }

  void _playSound() async {
    await _audioPlayer.play(AssetSource('audio/sound.mp3'));
  }

  void onScanned(String rawValue, Uint8List image) async {
    File imageFile = await uint8ListToFile(image, 'scanned_qr.png');
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final copiedImage = await imageFile.copy('${appDir.path}/$fileName');

    // Sca(content: rawValue, date: currentDateTime, image: imageFile);
    final id = await ref
        .read(scanHistoryProvider.notifier)
        .insertData(rawValue,  copiedImage.path, currentDateTime);


    _mobileScannerController.stop();
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => ScannedDataScreen(
              id: id,
            )));
  }

  // get date and formate

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobileScannerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(const Offset(0, -100)),
      width: 300,
      height: 250,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      // Ensure camera extends behind the AppBar
      extendBody: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnalyzeImageButton(
              controller: _mobileScannerController,
              isFromDrawer: false,
            ),
            const SizedBox(
              width: 20,
            ),
            ToogleFlashlightButton(controller: _mobileScannerController),
            const SizedBox(
              width: 20,
            ),
            SwitchCameraButton(controller: _mobileScannerController),
          ],
        ),
      ),
      drawer: const DrawerMenu(
        isFromScan: true,
      ),
      body: Stack(
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            scanWindow: useScanWindow ? scanWindow : null,
            controller: _mobileScannerController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;

              final Uint8List? image = capture.image;

              if (barcodes.isNotEmpty) {
                for (final barcode in barcodes) {
                  _playSound();
                  if (barcode.rawValue == null) {
                    return;
                  }

                  if (image != null) onScanned(barcode.rawValue!, image);

                  return;
                }
              } else {
                print("Empty barcode");
              }
            },
            errorBuilder: (context, error, dfs) {
              return ScannerErrorWidget(error: error);
            },
          ),
          if (!kIsWeb && useScanWindow)
            ScanWindowOverlay(
              scanWindow: scanWindow,
              controller: _mobileScannerController,
            ),
          if (!kIsWeb)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 60),
                  color: const Color.fromRGBO(0, 0, 0, 0.4),
                  child: ZoomScaleSlider(controller: _mobileScannerController)),
            )
        ],
      ),
    );
  }
}
