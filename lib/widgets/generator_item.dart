import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/model.dart/generate_qr_model.dart';

class GeneratorItem extends ConsumerWidget {
  final bool isFirst;
  final bool isLast;
  final GenerateQrModel qrModel;
  final Function(GenerateQrModel qrModel, BuildContext context, WidgetRef ref)
      onTap;

  const GeneratorItem(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.qrModel,
      required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isFirst) {
      return InkWell(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        onTap: () {
          onTap(qrModel, context, ref);
        },
        child: ListTile(
          leading: Icon(qrModel.icon),
          title: Text(qrModel.title.name[0].toUpperCase() +
              qrModel.title.name.substring(1)),
          shape: const Border(bottom: BorderSide()),
        ),
      );
    }

    if (isLast) {
      return InkWell(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        onTap: () {
          onTap(qrModel, context, ref);
        },
        child: ListTile(
          leading: Icon(qrModel.icon),
          title: Text(qrModel.title.name[0].toUpperCase() +
              qrModel.title.name.substring(1)),
        ),
      );
    }

    return ListTile(
      onTap: () {
        onTap(qrModel, context, ref);
      },
      leading: Icon(qrModel.icon),
      title: Text(qrModel.title.name[0].toUpperCase() +
          qrModel.title.name.substring(1)),
      shape: const Border(bottom: BorderSide()),
    );
  }
}
