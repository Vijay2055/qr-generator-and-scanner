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
  void initState() {
    // TODO: implement initState
    super.initState();

    _phoneController.addListener(_updateParent);
  }

  void _updateParent() {
    final phone = _phoneController.text;
    final data = Phone(phone: phone);
    widget.onChange(data);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      maxLength: 14,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Phone'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
