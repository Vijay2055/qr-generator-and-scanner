import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class UpcE extends StatefulWidget {
  const UpcE({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<UpcE> createState() => _UpcEState();
}

class _UpcEState extends State<UpcE> {
  final _upceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _upceController.addListener(_updateParent);
  }

  void _updateParent() {
    final upce_data = _upceController.text;
    final data = Upce(upce: upce_data);

    widget.onChange(data);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _upceController,
      keyboardType: TextInputType.number,
      maxLength: 7,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }

        final isValidUPC = RegExp(r'^\d{7}$'); // exactly 12 digits
        if (!isValidUPC.hasMatch(value)) {
          return "Invalid input";
        }
        return null;
      
      },
    );
  }
}
