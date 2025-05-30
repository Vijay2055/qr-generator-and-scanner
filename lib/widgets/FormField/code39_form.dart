import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class Code39Form extends StatefulWidget {
  const Code39Form({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<Code39Form> createState() => _Code39FormState();
}

class _Code39FormState extends State<Code39Form> {
  final _commonController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commonController.addListener(_updateParent);
  }

  void _updateParent() {
    final code39 = _commonController.text;
    final data = Code39(code39: code39);
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
          return 'Invalid input';
        }
        return null;
      },
    );
  }
}
