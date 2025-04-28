import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class ConnectWifiButton extends StatefulWidget {
  const ConnectWifiButton({super.key, required this.content});
  final String content;

  @override
  _ConnectWifiButtonState createState() => _ConnectWifiButtonState();
}

class _ConnectWifiButtonState extends State<ConnectWifiButton> {
  bool _isConnecting = false;

  Future<void> _connectWifi() async {
    setState(() {
      _isConnecting = true;
    });

    String qrCode = widget.content;
    RegExp wifiRegex = RegExp(r'WIFI:S:([^;]+);(?:T:([^;]*);)?(?:P:([^;]*);)?(?:H:([^;]*);)?');

    Match? match = wifiRegex.firstMatch(qrCode);

    if (match == null) {
      _showSnackBar("Invalid Wi-Fi QR Code");
      setState(() {
        _isConnecting = false;
      });
      return;
    }

    String ssid = match.group(1) ?? "";
    String password = match.group(3) ?? "";



    try {
      // Check if Wi-Fi is enabled
      bool isWifiEnabled = await WiFiForIoTPlugin.isEnabled();
      if (!isWifiEnabled) {
        _showSnackBar("Wi-Fi is disabled. Please enable it first.");
        setState(() {
          _isConnecting = false;
        });
        return;
      }

      // Connect to Wi-Fi
      await WiFiForIoTPlugin.findAndConnect(ssid, password: password);

      // Wait a bit and check if connected
      await Future.delayed(const Duration(seconds: 3));

      List<WifiNetwork>? networks = await WiFiForIoTPlugin.loadWifiList();
      bool isConnected = networks.any((wifi) => wifi.ssid == ssid);

      if (isConnected) {
        _showSnackBar("Connected to Wi-Fi: $ssid");
      } else {
        _showSnackBar("Failed to connect to Wi-Fi");
      }
    } catch (e) {
      _showSnackBar("Error: ${e.toString()}");
    } finally {
      setState(() {
        _isConnecting = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isConnecting ? null : _connectWifi,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi,
              size: 30, color: _isConnecting ? Colors.grey : Colors.blue),
          Text(_isConnecting ? "Connecting..." : "Connect"),
        ],
      ),
    );
  }
}
