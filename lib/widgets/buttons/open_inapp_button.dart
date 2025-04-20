import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenInAppButton extends StatelessWidget {
  const OpenInAppButton({super.key, required this.urlData});
  final String urlData;
  //  _launchURLBrowser() async {
  //   var _url = Uri.parse(urlData);
  //   if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

  Future<void> _launchInAppWithBrowserOptions(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
      browserConfiguration: const BrowserConfiguration(showTitle: true),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final uriData = Uri.parse(urlData);
        _launchInAppWithBrowserOptions(uriData);
      },
      child: const Column(
        children: [
          Icon(
            Icons.open_in_browser,
            size: 24,
          ),
          Text('Open'),
        ],
      ),
    );
  }
}
