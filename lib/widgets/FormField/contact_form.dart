import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _nameController = TextEditingController();
  final _organizationController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _organizationController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _nameController.addListener(_updateParent);
    _addressController.addListener(_updateParent);
    _emailController.addListener(_updateParent);
    _phoneController.addListener(_updateParent);
    _organizationController.addListener(_updateParent);
    _notesController.addListener(_updateParent);
    super.initState();
  }

  void _updateParent() {
    final data = ContactData(
        email: _emailController.text,
        name: _nameController.text,
        address: _addressController.text,
        note: _notesController.text,
        org: _organizationController.text,
        phone: _phoneController.text);

    widget.onChange(data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Full name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _organizationController,
          decoration: const InputDecoration(
            labelText: 'Organization',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _addressController,
          decoration: const InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _notesController,
          decoration: const InputDecoration(
            hintText: 'Notes',
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
