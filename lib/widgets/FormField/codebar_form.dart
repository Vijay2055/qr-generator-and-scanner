import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class CodebarForm extends StatefulWidget {
  const CodebarForm({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<CodebarForm> createState() => _CodebarFormState();
}

class _CodebarFormState extends State<CodebarForm> {
  final _codebarController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _codebarController.addListener(_updateParent);
  }

  void _updateParent() {
    final codebar_data = _codebarController.text;
    final data = Codebar(codebar: codebar_data);

    widget.onChange(data);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _codebarController,
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
