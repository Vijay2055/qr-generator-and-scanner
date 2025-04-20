import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _emailController = TextEditingController();
  final _subController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _subController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _emailController.addListener(_updateParent);
    _subController.addListener(_updateParent);
    _bodyController.addListener(_updateParent);
    super.initState();
  }

  void _updateParent() {
    final data = EmailData(
        body: _bodyController.text,
        subject: _subController.text,
        to: _emailController.text);

    widget.onChange(data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is Required';
            }

            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _subController,
          decoration: const InputDecoration(
            labelText: 'Subject',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _bodyController,
          decoration: const InputDecoration(
            hintText: 'Body',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 30,
        ),
      ],
    );
  }
}
