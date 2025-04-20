import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_scanner/data/TypeCategory.dart';
import 'package:qr_scanner/providers/scan_state.dart';
import 'package:qr_scanner/screens/scanned_data_screen.dart';

class FavScreen extends ConsumerWidget {
  const FavScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanData = ref.watch(scanHistoryProvider);
    final favData = scanData.where((scan) => scan.isFav == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: Center(
          child: favData.isEmpty
              ? const Text("No Favorite Scan Data")
              : ListView.builder(
                  itemCount: favData.length,
                  itemBuilder: (ctx, index) => Card(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        elevation: 3,
                        child: ListTile(
                          isThreeLine: true,
                          onTap: () {
                            final id = favData[index].id;

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ScannedDataScreen(
                                      id: id!,
                                    )));
                          },
                          leading: Icon(categoryIcon(favData[index].category)),
                          title: Text(favData[index].title.isEmpty
                              ? favData[index].category.name.toUpperCase()
                              : favData[index].title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(favData[index].time),
                              Text(favData[index].content)
                            ],
                          ),
                          trailing: const Icon(Icons.star),
                        ),
                      ))),
    );
  }
}
