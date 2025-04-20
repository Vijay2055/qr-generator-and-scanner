import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required this.data});
  final String data;

  Future<void> _shareData() async {
    final result = await Share.share(data);

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing my website!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: _shareData, icon: const Icon(Icons.share));
  }
}
