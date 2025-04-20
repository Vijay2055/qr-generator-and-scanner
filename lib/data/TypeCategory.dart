
import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/scann_history_model.dart';
 IconData categoryIcon(Category iconCat) {
    if (iconCat == Category.wifi) {
      return Icons.wifi;
    } else if (iconCat == Category.text) {
      return Icons.sms;
    }
    else if (iconCat == Category.url) {
      return Icons.link_rounded;
    }

    else if (iconCat == Category.phone) {
      return Icons.phone_android;
    }

    else if (iconCat == Category.email) {
      return Icons.email;
    }

    else if (iconCat == Category.barcode) {
      return Icons.qr_code;
    }

    else  {
      return Icons.sms;
    }
  }

