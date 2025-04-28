import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/data/list_of_generator_cat.dart';
import 'package:qr_scanner/model.dart/generate_qr_model.dart';
import 'package:qr_scanner/providers/qr_create_provider.dart';
import 'package:qr_scanner/screens/create_qr_screen.dart';
import 'package:qr_scanner/widgets/drawer_menu.dart';
import 'package:qr_scanner/widgets/generator_item.dart';

class GenerateQrScreen extends ConsumerWidget {
  const GenerateQrScreen({super.key});

  void _onTap(GenerateQrModel qrModel, BuildContext context, WidgetRef ref) {
    ref.read(qrProvider.notifier).reset();
    ref.read(qrProvider.notifier).updateTitle(qrModel.title.name);

    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => CreateQrScreen(qrModel: qrModel)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate"),
      ),
      drawer: const DrawerMenu(isFromScan: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                "Create Qr",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Card(
              child: Column(
                children: list_qr_generator_type
                    .map((item) => GeneratorItem(
                          isFirst: list_qr_generator_type.first == item,
                          isLast: list_qr_generator_type.last == item,
                          qrModel: item,
                          onTap: _onTap,
                        ))
                    .toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                "Other Types",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Card(
              child: Column(
                children: list_other_generator_type
                    .map((item) => GeneratorItem(
                          isFirst: list_other_generator_type.first == item,
                          isLast: list_other_generator_type.last == item,
                          qrModel: item,
                          onTap: _onTap,
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
