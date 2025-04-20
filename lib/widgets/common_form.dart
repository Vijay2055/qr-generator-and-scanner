import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class CommonForm extends StatefulWidget {
  const CommonForm({super.key, required this.onChange});
  final Function(QrData value) onChange;


  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  final _commonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _commonController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.multiline,
      minLines: 10,
      maxLines: 30,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
