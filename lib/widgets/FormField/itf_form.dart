import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class ItfForm extends StatefulWidget {
  const ItfForm({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<ItfForm> createState() => _ItfFormState();
}

class _ItfFormState extends State<ItfForm> {
  final _itfController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _itfController.addListener(_updateParent);
  }

  void _updateParent() {
    final itf_data = _itfController.text;
    final data = Itf(itf: itf_data);

    widget.onChange(data);
  }

  bool isNumericOnly(String value) {
    final numericRegex = RegExp(r'^\d+$');
    return numericRegex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _itfController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        } else if (value.trim().length % 2 != 0 || !isNumericOnly(value)) {
          return "Invalid Entry";
        }
        return null;
      },
    );
  }
}
