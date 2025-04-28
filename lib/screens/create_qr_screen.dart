import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/model.dart/generate_qr_model.dart';
import 'package:qr_scanner/model.dart/qr_data/qr_data.dart';
import 'package:qr_scanner/model.dart/scann_history_model.dart';
import 'package:qr_scanner/providers/qr_create_provider.dart';
import 'package:qr_scanner/screens/qr_code_screen.dart';
import 'package:qr_scanner/widgets/FormField/contact_form.dart';
import 'package:qr_scanner/widgets/FormField/ean_13_from.dart';
import 'package:qr_scanner/widgets/FormField/ean_8_form.dart';
import 'package:qr_scanner/widgets/FormField/email_form.dart';
import 'package:qr_scanner/widgets/FormField/geo_form.dart';
import 'package:qr_scanner/widgets/FormField/itf_form.dart';
import 'package:qr_scanner/widgets/FormField/phone_form.dart';
import 'package:qr_scanner/widgets/FormField/sms_form.dart';
import 'package:qr_scanner/widgets/FormField/text_form.dart';
import 'package:qr_scanner/widgets/FormField/upc_e.dart';
import 'package:qr_scanner/widgets/FormField/url_form.dart';
import 'package:qr_scanner/widgets/FormField/wifi_from.dart';
import 'package:qr_scanner/widgets/common_form.dart';
import 'package:qr_scanner/widgets/drawer_menu.dart';
import 'package:qr_scanner/widgets/upc_a_form.dart';

class CreateQrScreen extends ConsumerStatefulWidget {
  const CreateQrScreen({super.key, required this.qrModel});
  final GenerateQrModel qrModel;

  @override
  ConsumerState<CreateQrScreen> createState() => _CreateQrScreenState();
}

class _CreateQrScreenState extends ConsumerState<CreateQrScreen> {
  final _formKey = GlobalKey<FormState>();
  QrData? qrData;

  void onChange(QrData data) {
    qrData = data;
  }

  Widget _buildFromFields() {
    final title = widget.qrModel.title;
    switch (title) {
      case Category.wifi:
        return WifiFrom(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.text:
        return TextForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.url:
        return UrlForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.contact:
        return ContactForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.email:
        return EmailForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.geo:
        return GeoForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.sms:
        return SmsForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.phone:
        return PhoneForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );

      case Category.barcode:
        return const Text('Undefined');

      case Category.ean_8:
        // TODO: Handle this case.
        return Ean8Form(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.ean_13:
        return Ean13From(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.upc_e:
        return UpcE(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.upc_a:
        return UpcAForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.code_39:
        return CommonForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.code_93:
        return CommonForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.code_128:
        return CommonForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.itf:
        return ItfForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.pdf_417:
        return CommonForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.codebar:
        return CommonForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.data_matrix:
        return CommonForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
      case Category.aztec:
        return CommonForm(
          onChange: (QrData data) {
            onChange(data);
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Create'),
          actions: [
            IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (qrData == null) {
                      return;
                    }

                    ref
                        .read(qrProvider.notifier)
                        .updateContent(qrData!.getData());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => QrCodeScreen(
                              qrData: qrData!,
                              qrModel: widget.qrModel,
                            )));
                  }
                },
                icon: const Icon(Icons.done))
          ],
        ),
        drawer: const DrawerMenu(isFromScan: false),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(widget.qrModel.icon),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.qrModel.title.name[0].toUpperCase() +
                            widget.qrModel.title.name.substring(1),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildFromFields(),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
