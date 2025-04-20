import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class UpcE extends StatefulWidget {
  const UpcE({super.key, required this.onChange});
  final Function(QrData value) onChange;


  @override
  State<UpcE> createState() => _UpcEState();
}

class _UpcEState extends State<UpcE> {
  final _upceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _upceController,
      keyboardType: TextInputType.number,
      maxLength: 8,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
