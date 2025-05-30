import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class Pdf417Form extends StatefulWidget {
  const Pdf417Form({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<Pdf417Form> createState() => _Pdf417FormState();
}

class _Pdf417FormState extends State<Pdf417Form> {
  final _commonController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commonController.addListener(_updateParent);
  }

  void _updateParent() {
    final pdf_data = _commonController.text;
    final data = Pdf417(pdf417: pdf_data);
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
