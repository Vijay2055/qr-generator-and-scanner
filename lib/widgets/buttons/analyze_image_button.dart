import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:qr_scanner/providers/scan_state.dart';
import 'package:qr_scanner/screens/scanned_data_screen.dart';
import 'package:qr_scanner/utilities/getFomatedDate.dart';
import 'package:qr_scanner/utilities/uint_to_file.dart';

/// Button widget for analyze image function
class AnalyzeImageButton extends ConsumerStatefulWidget {
  /// Construct a new [AnalyzeImageButton] instance.
  const AnalyzeImageButton(
      {required this.controller, super.key, required this.isFromDrawer});
  final bool isFromDrawer;

  /// Controller which is used to call analyzeImage
  final MobileScannerController controller;

  @override
  ConsumerState<AnalyzeImageButton> createState() => _AnalyzeImageButtonState();
}

class _AnalyzeImageButtonState extends ConsumerState<AnalyzeImageButton> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playSound() async {
    await _audioPlayer.play(AssetSource('audio/sound.mp3'));
  }

  void onScanned(String rawValue, BuildContext context, Uint8List image,
      String dateTime) async {
    // final uuid = Uuid().v4();
    // File imageFile = await uint8ListToFile(image, 'scanned_qr_$uuid.png');
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // final copiedImage = await imageFile.copy('${appDir.path}/$fileName');

    final imagePath = await getFilePath(image);

    final id = await ref
        .read(scanHistoryProvider.notifier)
        .insertData(rawValue, imagePath, currentDateTime);

    widget.controller.stop();

    if (!context.mounted) return;

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => ScannedDataScreen(
              id: id,
            )));
  }

  Future<void> _onPressed(BuildContext context) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Analyze image is not supported on web'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      return;
    }

    final barcodes = await widget.controller.analyzeImage(
      image.path,
    );

    if (!context.mounted) {
      return;
    }

    if (barcodes == null || barcodes.barcodes.isEmpty) {
      return;
    }

    final barcodeLst = barcodes.barcodes;

    final Uint8List qrImage = await image.readAsBytes();

    for (final barcode in barcodeLst) {
      _playSound();
      if (barcode.rawValue == null) {
        return;
      }

      onScanned(barcode.rawValue!, context, qrImage, currentDateTime);
    }

    final snackBar = barcodes.barcodes.isNotEmpty
        ? const SnackBar(
            content: Text("Barcode found!"),
            backgroundColor: Colors.green,
          )
        : const SnackBar(
            content: Text('No barcode found!'),
            backgroundColor: Colors.red,
          );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFromDrawer) {
      return ListTile(
        leading: const Icon(Icons.image),
        title: const Text("Scan Image"),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).popUntil((route) => route.isFirst);
          _onPressed(
            context,
          );
        },
      );
    }
    return IconButton(
      color: Colors.white,
      icon: const Icon(Icons.image),
      iconSize: 22,
      onPressed: () => _onPressed(context),
    );
  }
}
