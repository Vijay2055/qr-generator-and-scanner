import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class TextForm extends StatefulWidget {
  const TextForm({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  final _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _textController.addListener(_updateParent);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();

    super.dispose();
  }

  void _updateParent() {
    final data = TextData(
      text: _textController.text,
    );

    widget.onChange(data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: 'Text',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 10,
          maxLines: 40,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ],
    );
  }
}
