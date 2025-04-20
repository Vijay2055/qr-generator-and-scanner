import 'package:flutter/material.dart';

import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';

enum EncryptionType { wpaWp2, wep, noPass }

class WifiFrom extends StatefulWidget {
  const WifiFrom({super.key, required this.onChange});
  final Function(QrData value) onChange;

  @override
  State<WifiFrom> createState() => _WifiFromState();
}

class _WifiFromState extends State<WifiFrom> {
  EncryptionType _encryptionType = EncryptionType.noPass;
  final _ssidController = TextEditingController();
  final _passController = TextEditingController();

  void _updateParent() {
    final data = WifiData(
        ssid: _ssidController.text,
        password: _passController.text,
        encryption: _encryptionType.name);

    widget.onChange(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    _ssidController.addListener(_updateParent);
    _passController.addListener(_updateParent);
    super.initState();
  }

  @override
  void dispose() {
    _ssidController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        TextFormField(
          controller: _ssidController,
          decoration: const InputDecoration(
            labelText: 'SSID/Network name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter wifi name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _passController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        DropdownMenu<EncryptionType>(
          width: double.infinity,
          initialSelection: _encryptionType,
          inputDecorationTheme:
              const InputDecorationTheme(border: OutlineInputBorder()),
          dropdownMenuEntries: EncryptionType.values
              .map((item) => DropdownMenuEntry(
                  value: item,
                  label: item.name == EncryptionType.wpaWp2.name
                      ? 'WPA/WPE'
                      : item.name == EncryptionType.wep.name
                          ? 'Wep'
                          : "No Password"))
              .toList(),
          onSelected: (value) {
            setState(() {
              _encryptionType = value!;
              _updateParent();
            });
          },
        )
      ],
    );
  }

  String getWifiData() {
    return 'WIFI:S:${_ssidController.text};T:WPA;P:${_passController.text};;';
  }
}
