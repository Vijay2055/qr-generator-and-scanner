import 'package:flutter/material.dart';
import 'package:qr_scanner/model.dart/generate_qr_model.dart';
import 'package:qr_scanner/model.dart/scann_history_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final list_qr_generator_type = [
  GenerateQrModel(title: Category.wifi, icon: Icons.wifi),
  GenerateQrModel(title: Category.url, icon: Icons.link),
  GenerateQrModel(title: Category.text, icon: Icons.text_fields_outlined),
  GenerateQrModel(title: Category.contact, icon: Icons.person_2_outlined),
  GenerateQrModel(title: Category.email, icon: Icons.email),
  GenerateQrModel(title: Category.sms, icon: Icons.sms),
  GenerateQrModel(title: Category.geo, icon: Icons.location_on_outlined),

];

final list_other_generator_type = [
  GenerateQrModel(title: Category.ean_8, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.ean_13, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.upc_e, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.upc_a, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.code_39, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.code_93, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.code_128, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.itf, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.pdf_417, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.codebar, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.data_matrix, icon: FontAwesomeIcons.barcode),
  GenerateQrModel(title: Category.aztec, icon: FontAwesomeIcons.barcode),
];
