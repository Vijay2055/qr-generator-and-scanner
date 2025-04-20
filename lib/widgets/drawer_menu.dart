import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/screens/fav_screen.dart';
import 'package:qr_scanner/screens/generate_qr_screen.dart';
import 'package:qr_scanner/screens/history_screen.dart';
import 'package:qr_scanner/screens/qr_scanner.dart';
import 'package:qr_scanner/widgets/buttons/analyze_image_button.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key, required this.isFromScan});
  final bool isFromScan;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Qr Code"),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.adf_scanner),
            title: const Text("Scan"),
            onTap: () {
              if (isFromScan) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const QrScanner()));
              }
            },
          ),
          AnalyzeImageButton(
              controller: MobileScannerController(), isFromDrawer: true),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("History"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const HistoryScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text("Favorite"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => const FavScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text("Generate Qr Code"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const GenerateQrScreen()));
            },
          )
        ],
      ),
    );
  }
}
