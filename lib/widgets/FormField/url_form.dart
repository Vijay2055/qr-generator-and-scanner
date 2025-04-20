import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class UrlForm extends StatefulWidget {
  const UrlForm({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<UrlForm> createState() => _UrlFormState();
}

class _UrlFormState extends State<UrlForm> {
  final _urlController = TextEditingController(text: 'http//:');

  void _updateParent() {
    final data = UrlData(
      url: _urlController.text,
    );

    widget.onChange(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    _urlController.addListener(_updateParent);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _urlController,
      decoration: const InputDecoration(
        labelText: 'Enter url',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Text field is requireed';
        }
        return null;
      },
    );
  }
}
