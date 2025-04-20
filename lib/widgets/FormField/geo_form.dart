import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

class GeoForm extends StatefulWidget {
  const GeoForm({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<GeoForm> createState() => _GeoFormState();
}

class _GeoFormState extends State<GeoForm> {
  final _latController = TextEditingController();
  final _longController = TextEditingController();
  final _queryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    _latController.addListener(_updateParent);
    _longController.addListener(_updateParent);
    _queryController.addListener(_updateParent);

    super.initState();
  }

  void _updateParent() {
    final data = GeoData(
      latitude: double.parse(_latController.text),
      longitude: double.parse(_longController.text),
      query: _queryController.text,
    );
    widget.onChange(data);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _latController.dispose();
    _longController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _latController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Latitude',
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
          controller: _longController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Longitude',
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
          controller: _queryController,
          decoration: const InputDecoration(
            labelText: 'Query',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
