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
  void initState() {
    // TODO: implement initState
    super.initState();
    _upcaController.addListener(_updateParent);
  }

  void _updateParent() {
    final upc_a = _upcaController.text;
    final data = Upca(upca: upc_a);

    widget.onChange(data);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _upcaController,
      keyboardType: TextInputType.number,
      maxLength: 11,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        final isValidUPC = RegExp(r'^\d{11}$'); // exactly 12 digits
        if (!isValidUPC.hasMatch(value)) {
          return "Invalid input";
        }
        return null;
      },
    );
  }
}
