import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToclipboard extends StatelessWidget {
  const CopyToclipboard({super.key, required this.urlData});
  final String urlData;

  Future<void> _copyToClipboard(BuildContext context) async {
    if (urlData.isNotEmpty) {
      try {
        await Clipboard.setData(ClipboardData(text: urlData));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to Clipboard!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to copy to clipboard.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _copyToClipboard(context);
        },
        icon: const Icon(Icons.copy));
  }
}
