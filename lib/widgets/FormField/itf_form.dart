import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class ItfForm extends StatefulWidget {
  const ItfForm({super.key, required this.onChange});
  final Function(QrData value) onChange;


  @override
  State<ItfForm> createState() => _ItfFormState();
}

class _ItfFormState extends State<ItfForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
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
