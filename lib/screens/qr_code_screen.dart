import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/model.dart/generate_qr_model.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/utilities/getFomatedDate.dart';
import 'package:qr_scanner/widgets/buttons/save_share_button.dart';

class QrCodeScreen extends ConsumerStatefulWidget {
  const QrCodeScreen({super.key, required this.qrData, required this.qrModel});

  final QrData qrData;
  final GenerateQrModel qrModel;

  @override
  ConsumerState<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends ConsumerState<QrCodeScreen> {
  final GlobalKey _globalKey = GlobalKey();
  int? _id;
  //  final rawValue =widget.qrData?.getData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _autoSaveQr();
  }

  void _autoSaveQr() {}
  @override
  Widget build(BuildContext context) {
    final data = widget.qrData.toMap();
    void _saveQrCode() {}
    void _shareQrCode() {}

    void _autoSaveToHistory() {}

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
                        widget.qrModel.title.name,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.star_outline),
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
              child: RepaintBoundary(
                key: _globalKey,
                child: QrImageView(
                  data: widget.qrData.getData(),
                  size: 250,
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
                  onTap: _saveQrCode,
                  title: "Save",
                  icon: Icons.save,
                ),
                const SizedBox(
                  width: 30,
                ),
                SaveShareButton(
                  onTap: _shareQrCode,
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
