import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/data/TypeCategory.dart';
import 'package:qr_scanner/model.dart/scann_history_model.dart';
import 'package:qr_scanner/providers/scan_state.dart';
import 'package:qr_scanner/screens/qr_scanner.dart';
import 'package:qr_scanner/widgets/buttons/connect_wifi_button.dart';
import 'package:qr_scanner/widgets/buttons/copy_toClipboard.dart';
import 'package:qr_scanner/widgets/buttons/open_inapp_button.dart';
import 'package:qr_scanner/widgets/buttons/share_button.dart';
import 'package:qr_scanner/widgets/drawer_menu.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannedDataScreen extends ConsumerWidget {
  const ScannedDataScreen({super.key, required this.id,this.isFromOtherScreen=false});
  final int id;
  final bool isFromOtherScreen;

  _launchURLBrowser(String content) async {
    var url = Uri.parse(content);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _addToFav(WidgetRef ref, bool isFav) {
    ref.read(scanHistoryProvider.notifier).updateFav(id, isFav);
  }

  Future<void> _showEditDialogue(
      BuildContext context, WidgetRef ref, String text) async {
    TextEditingController titleController = TextEditingController(text: text);
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              elevation: 4,
              title: const Text(
                'Title Name',
                style: TextStyle(fontSize: 18),
              ),
              content: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: 'Enter title', border: OutlineInputBorder()),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      ref
                          .read(scanHistoryProvider.notifier)
                          .updateTitle(id, titleController.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Save"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScanHistoryModel scanData = ref.watch(scanHistoryProvider).firstWhere(
          (scan) => scan.id == id,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr Scanner"),
      ),
      drawer: const DrawerMenu(
        isFromScan: false,
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, result) async {
          if (didPop) {
            return;
          }
          if(isFromOtherScreen){
            Navigator.of(context).pop();
            return;
          }
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const QrScanner()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(categoryIcon(scanData.category)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      scanData.title.isEmpty
                          ? scanData.category.name
                          : scanData.title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      scanData.time,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _showEditDialogue(
                                  context,
                                  ref,
                                  scanData.title.isEmpty
                                      ? scanData.category.name
                                      : scanData.title);
                            },
                            icon: const Icon(Icons.edit)),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              _addToFav(ref, !scanData.isFav);
                            },
                            icon: Icon(scanData.isFav
                                ? Icons.star
                                : Icons.star_border)),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _launchURLBrowser(scanData.content);
                  },
                  child: Text(scanData.content),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    if (scanData.category == Category.wifi)
                      ConnectWifiButton(content: scanData.content),
                    const SizedBox(
                      width: 10,
                    ),
                    if (scanData.category == Category.url)
                      OpenInAppButton(urlData: scanData.content),
                    const SizedBox(
                      width: 10,
                    ),
                    ShareButton(data: scanData.content),
                    const SizedBox(
                      width: 10,
                    ),
                    CopyToclipboard(urlData: scanData.content)
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 2,
                    child:
                    Padding(
                    padding: const EdgeInsets.all(1.0),
                      child:Image.file(
                      File(scanData.image),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ), )

                    ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
