import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class UpcAForm extends StatefulWidget {
  const UpcAForm({super.key, required this.onChange});
  final Function(QrData value) onChange;


  @override
  State<UpcAForm> createState() => _UpcAFormState();
}

class _UpcAFormState extends State<UpcAForm> {
  final _upcaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _upcaController,
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
