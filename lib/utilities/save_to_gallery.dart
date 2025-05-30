import 'package:flutter/material.dart';
import 'package:gal/gal.dart';

void saveToGallary(String path, BuildContext context) async {
  String message = 'You image is not save';
  try {
    await Gal.putImage(path);
    message = "Image is saved succefully";
  } catch (e) {
    message = "Image can't be saved due to $e";
  }
  if (context.mounted) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
