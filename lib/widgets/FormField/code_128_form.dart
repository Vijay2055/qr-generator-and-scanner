import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class Code128Form extends StatefulWidget {
  const Code128Form({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<Code128Form> createState() => _Code128FormState();
}

class _Code128FormState extends State<Code128Form> {
  final _commonController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commonController.addListener(_updateParent);
  }

  void _updateParent() {
    final code128 = _commonController.text;
    final data = Code128(code128: code128);
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
