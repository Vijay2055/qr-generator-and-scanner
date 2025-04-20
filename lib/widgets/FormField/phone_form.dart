import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class PhoneForm extends StatefulWidget {
  const PhoneForm({super.key, required this.onChange});
  final Function(QrData value) onChange;


  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _phoneController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
      labelText: 'Phone'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
