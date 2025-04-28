import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/data/TypeCategory.dart';

import 'package:qr_scanner/providers/scan_state.dart';
import 'package:qr_scanner/screens/scanned_data_screen.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});
  void _onLongPress(BuildContext context, int id, WidgetRef ref) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text(
                "Are you sure, you want to delete?",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              icon: const Icon(
                Icons.warning,
                size: 50,
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      final count = await ref
                          .read(scanHistoryProvider.notifier)
                          .deleteQR(id);
                      if (count > 0) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Qr Code is Deleted")));
                        }
                      }
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No")),
              ],
            ),
        barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final histories = ref.watch(scanHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Center(
          child: histories.isEmpty
              ? const Text("No scan history")
              : ListView.builder(
                  itemCount: histories.length,
                  itemBuilder: (ctx, index) => Card(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        elevation: 3,
                        child: ListTile(
                          isThreeLine: true,
                          onLongPress: () {
                            final id = histories[index].id;
                            _onLongPress(context, id!, ref);
                          },
                          onTap: () {
                            final id = histories[index].id;

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ScannedDataScreen(
                                      id: id!,
                                  isFromOtherScreen: true,
                                    )));
                          },
                          leading:
                              Icon(categoryIcon(histories[index].category)),
                          title: Text(histories[index].title.isEmpty
                              ? histories[index].category.name.toUpperCase()
                              : histories[index].title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(histories[index].time),
                              Text(histories[index].content)
                            ],
                          ),
                          trailing: Icon(histories[index].isFav
                              ? Icons.star
                              : Icons.star_border),
                        ),
                      ))),
    );
  }
}
