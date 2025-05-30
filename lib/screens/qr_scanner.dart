import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:qr_scanner/overlays/QRScannerOverlay.dart';

import 'package:qr_scanner/providers/scan_state.dart';
import 'package:qr_scanner/utilities/getFomatedDate.dart';
import 'package:qr_scanner/utilities/uint_to_file.dart';
import 'package:qr_scanner/widgets/buttons/analyze_image_button.dart';
import 'package:qr_scanner/widgets/buttons/switch_camera_button.dart';
import 'package:qr_scanner/widgets/buttons/toogle_flashlight_button.dart';
import 'package:qr_scanner/widgets/drawer_menu.dart';
import 'package:qr_scanner/widgets/scanner_exception_widget.dart';
import 'package:qr_scanner/screens/scanned_data_screen.dart';
import 'package:qr_scanner/widgets/zoom_scale_slider.dart';

class QrScanner extends ConsumerStatefulWidget {
  const QrScanner({super.key});
  @override
  ConsumerState<QrScanner> createState() {
    return _QrScannerState();
  }
}

class _QrScannerState extends ConsumerState<QrScanner> with WidgetsBindingObserver{
  final AudioPlayer _audioPlayer = AudioPlayer();
  static const useScanWindow = true;
  bool useBarcodeOverlay = true;

  late MobileScannerController _mobileScannerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Listen for app lifecycle
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
    final imagePath = await getFilePath(image);
    final id = await ref
        .read(scanHistoryProvider.notifier)
        .insertData(rawValue, imagePath, currentDateTime);

   await _mobileScannerController.stop();
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
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
    _mobileScannerController.dispose();
  }

 

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _mobileScannerController.start();
    } else if (state == AppLifecycleState.paused) {
      _mobileScannerController.stop();
    }
  }
  @override
  Widget build(BuildContext context) {

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
              } 
            },
            errorBuilder: (context, error, dfs) {
              return ScannerErrorWidget(error: error);
            },
          ),
          if (!kIsWeb && useScanWindow)
            if (!kIsWeb && useScanWindow)
            const  QRScannerOverlay(overlayColour: Colors.black54),


          if (!kIsWeb)
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child:  SizedBox(
                  child: ZoomScaleSlider(controller: _mobileScannerController)),
            )
        ],
      ),
    );
  }
}
