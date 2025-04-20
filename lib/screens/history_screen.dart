import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/data/TypeCategory.dart';

import 'package:qr_scanner/providers/scan_state.dart';
import 'package:qr_scanner/screens/scanned_data_screen.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});
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
                          onTap: () {
                            final id = histories[index].id;

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ScannedDataScreen(
                                      id: id!,
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
