import 'package:flutter/material.dart';

class SaveShareButton extends StatelessWidget {
  const SaveShareButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon});
  final Function() onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
