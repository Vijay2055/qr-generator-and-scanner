import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class Ean13From extends StatefulWidget {
  const Ean13From({super.key, required this.onChange});
  final Function(QrData value) onChange;


  @override
  State<Ean13From> createState() => _Ean13FromState();
}

class _Ean13FromState extends State<Ean13From> {
  final _ean13Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _ean13Controller,
      keyboardType: TextInputType.number,
      maxLength: 12,
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
