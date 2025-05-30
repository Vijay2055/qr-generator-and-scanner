import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class Code93Form extends StatefulWidget {
  const Code93Form({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<Code93Form> createState() => _Code39FormState();
}

class _Code39FormState extends State<Code93Form> {
  final _commonController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commonController.addListener(_updateParent);
  }

  void _updateParent() {
    final code93 = _commonController.text;
    final data = Code93(code93: code93);
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
        } else if (value.contains(',')) {
          return "Invalid inputs";
        }
        return null;
      },
    );
  }
}
