import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class AztecForm extends StatefulWidget {
  const AztecForm({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<AztecForm> createState() => _AxtecFormState();
}

class _AxtecFormState extends State<AztecForm> {
  final _commonController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commonController.addListener(_updateParent);
  }

  void _updateParent() {
    final code = _commonController.text;
    final data = DataMatrix(code: code);
    widget.onChange(data);
  }

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
