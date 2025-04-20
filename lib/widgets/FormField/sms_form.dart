import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class SmsForm extends StatefulWidget {
  const SmsForm({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<SmsForm> createState() => _SmsFormState();
}

class _SmsFormState extends State<SmsForm> {
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _phoneController.addListener(_updateParent);
    _messageController.addListener(_updateParent);
    super.initState();
  }

  void _updateParent() {
    final data = SmsData(
      message: _messageController.text,
      number: _phoneController.text,
    );

    widget.onChange(data);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter phone number';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _messageController,
          decoration: const InputDecoration(
            hintText: 'Message',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 10,
          maxLines: 100,
        ),
      ],
    );
  }

  String getSmsData() {
    return 'SMSTO:${_phoneController.text}:${_messageController.text}';
  }
}
