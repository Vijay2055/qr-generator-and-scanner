import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class BarcodeGenerator extends StatelessWidget {
  const BarcodeGenerator({super.key, required this.data});

  final QrData data;

  @override 
  Widget build(BuildContext context) {
    final barcodeType = switch ((data as BarcodeGeneratorType).barcodeType) {
      'ean8' => Barcode.ean8(),
      'ean13' => Barcode.ean13(),
      'upce' => Barcode.upcE(),
      'upca' => Barcode.upcA(),
      'code39' => Barcode.code39(),
      'code93' => Barcode.code93(),
      'code128' => Barcode.code128(), 
      'itf' => Barcode.itf(),
      'pdf417' => Barcode.pdf417(),
      'codebar' => Barcode.codabar(),
      'datamatrix' => Barcode.dataMatrix(),
      'aztec' => Barcode.aztec(),
      // TODO: Handle this case.
      String() => throw UnimplementedError(),
    };

    return BarcodeWidget(
      
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      data: data.getData(),
      barcode: barcodeType,
      errorBuilder: (context, error) => Text(error),
    );
  }
}
