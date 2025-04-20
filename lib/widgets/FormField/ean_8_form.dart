import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class Ean8Form extends StatefulWidget {
  const Ean8Form({super.key, required this.onChange});
  final Function(QrData value) onChange;


  @override
  State<Ean8Form> createState() => _Ean8FormState();
}

class _Ean8FormState extends State<Ean8Form> {
  final _ean8Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _ean8Controller,
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
