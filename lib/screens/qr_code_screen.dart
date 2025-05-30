import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/model.dart/generate_qr_model.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/model.dart/scann_history_model.dart';
import 'package:qr_scanner/providers/qr_create_provider.dart';
import 'package:qr_scanner/providers/scan_state.dart';
import 'package:qr_scanner/utilities/getFomatedDate.dart';
import 'package:qr_scanner/utilities/save_to_gallery.dart';
import 'package:qr_scanner/utilities/uint_to_file.dart';
import 'package:qr_scanner/widgets/barcode_generator.dart';
import 'package:qr_scanner/widgets/buttons/save_share_button.dart';
import 'package:share_plus/share_plus.dart';

class QrCodeScreen extends ConsumerStatefulWidget {
  const QrCodeScreen({
    super.key,
    required this.qrData,
    required this.qrModel,
    this.isBarcode = false,
  });

  final QrData qrData;
  final GenerateQrModel qrModel;
  final isBarcode;

  @override
  ConsumerState<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends ConsumerState<QrCodeScreen> {
  final GlobalKey _globalKey = GlobalKey();
  int? _id;
  String? imagePath;
  TextEditingController? _titleController;

  //  final rawValue =widget.qrData?.getData();

  @override
  void initState() {
    // TODO: implement initState
    _titleController = TextEditingController(text: ref.read(qrProvider).title);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
          const Duration(milliseconds: 300)); // give extra time
      _autoSaveToHistory();
    });
    super.initState();
  }

  Future<void> _autoSaveToHistory() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Wait until the boundary is ready
    // if (boundary.debugNeedsPaint) {
    //   await Future.delayed(const Duration(milliseconds: 100));
    //   return _autoSaveToHistory(); // Try again after delay
    // }

    final image = await boundary.toImage();
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    imagePath = await getFilePath(pngBytes);

    if (ref.read(qrProvider).isSaved == false) {
      _id = await ref
          .read(scanHistoryProvider.notifier)
          .insertData(widget.qrData.getData(), imagePath!, currentDateTime);
      if (_id == null) {
        return;
      }
      ref.read(qrProvider.notifier).updateId(_id!, true);
    } else {
      _id = ref.read(qrProvider).id;

      if (_id == null) {
        return;
      }
      ScanHistoryModel? prevData =
          (await ref.read(scanHistoryProvider.notifier).getSingleData(_id!));

      if (prevData == null) {
        return;
      }

      if (widget.qrData.getData() == prevData.content) {
        return;
      } else {
        try {
          await ref
              .read(scanHistoryProvider.notifier)
              .updateCont(_id!, widget.qrData.getData(), imagePath!);
        } catch (e) {
          print('failed to update content due to $e');
        }
      }
    }
  }

  void shareQrCode() async {
    String message = "Your qr_code can't share";
    try {
      final sharparams = ShareParams(
          text: 'Qr_Scanner',
          files: [XFile(imagePath!, mimeType: 'image/png')]);
      final result = await SharePlus.instance.share(sharparams);
      if (result.status == ShareResultStatus.success) {
        message = 'Thank you for sharing your qr_code';
      }
    } catch (e) {
      message = "Can't share due to $e";
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _onEdit() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Title'),
            content: TextField(
              controller: _titleController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (_titleController == null) {
                    return;
                  }

                  ref
                      .read(qrProvider.notifier)
                      .updateTitle(_titleController!.text);

                  if (_id != null) {
                    ref
                        .read(scanHistoryProvider.notifier)
                        .updateTitle(_id!, _titleController!.text);
                  }

                  Navigator.of(context).pop();
                },
                child: const Text("Save"),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_titleController != null) {
      _titleController!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.qrData.toMap();
    final createQrData = ref.watch(qrProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(widget.qrModel.icon),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        createQrData.title!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _onEdit,
                        icon: const Icon(Icons.edit),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      IconButton(
                        onPressed: () {
                          if (_id != null) {
                            ref
                                .read(qrProvider.notifier)
                                .updateIsFav(!createQrData.isFav!);

                            ref
                                .read(scanHistoryProvider.notifier)
                                .updateFav(_id!, !createQrData.isFav!);
                          }
                        },
                        icon: Icon(createQrData.isFav == false
                            ? Icons.star_outline
                            : Icons.star),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(123, 175, 171, 171)),
              height: 350,
              child: Container(
                color: Colors.white,
                child: RepaintBoundary(
                  key: _globalKey,
                  child: widget.isBarcode
                      ? Center(
                          child: BarcodeGenerator(data: widget.qrData))
                      : QrImageView(
                          data: widget.qrData.getData(),
                          size: 250,
                          backgroundColor: Colors
                              .white, // add backgroundColor inside QrImage
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SaveShareButton(
                  onTap: () {
                    if (imagePath == null) {
                      return;
                    }
                    saveToGallary(imagePath!, context);
                  },
                  title: "Save",
                  icon: Icons.save,
                ),
                const SizedBox(
                  width: 30,
                ),
                SaveShareButton(
                  onTap: shareQrCode,
                  icon: Icons.share,
                  title: "Share",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: data.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${entry.key}:',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            entry.value,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
